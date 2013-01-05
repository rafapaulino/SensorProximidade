//
//  PrincipalViewController.m
//  SensorProximidade
//
//  Created by Rafael Brigagão Paulino on 12/09/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import "PrincipalViewController.h"

@interface PrincipalViewController ()

@end

@implementation PrincipalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIDevice *device = [UIDevice currentDevice];
    
    //possibilitando a recepcao de eventos relacionados ao sensor de proximidade
    device.proximityMonitoringEnabled = YES;
    
    //excesso de seguranca, verificar se o sensor esta realmente sendo monitorado
    if (device.proximityMonitoringEnabled == YES) {
       //cadastrar essa viewcontroller como observadora de eventos relacionados ao sensor de proximidade
        [[NSNotificationCenter defaultCenter]addObserverForName:UIDeviceProximityStateDidChangeNotification object:nil queue:[[NSOperationQueue alloc] init] usingBlock:^(NSNotification *note) {
            
            if (device.proximityState == YES)
            {
                NSLog(@"Algo se aproximou!");
            }
            else
            {
               NSLog(@"Nada está perto do sensor!"); 
            }
            
        }];
    }
    
    //via metodo
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(meuMetodo) name:UIDeviceProximityStateDidChangeNotification object:nil];
}

-(void)meuMetodo:(NSNotification*)notificacao
{
    NSLog(@"Chamou meu metodo!");
    //remove na primeira vez que o metodo e executado
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceProximityStateDidChangeNotification object:nil];
    
    
    //mandar um post para o notification center
    //[[NSNotificationCenter defaultCenter] postNotificationName:<#(NSString *)#> object:<#(id)#>];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
