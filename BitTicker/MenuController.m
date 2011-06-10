//
//  MenuController.m
//  BitTicker
//
//  Created by steve on 6/10/11.
//  Copyright 2011 none. All rights reserved.
//

#import "MenuController.h"
#import "Ticker.h"
#import "Wallet.h"
#import "StatusItemView.h"

@implementation MenuController

@synthesize tickerValue = _tickerValue;

- (id)init
{
    self = [super init];
    if (self) {
		currencyFormatter = [[NSNumberFormatter alloc] init];
		currencyFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
		currencyFormatter.currencyCode = @"USD"; // TODO: Base on market currency
		currencyFormatter.thousandSeparator = @","; // TODO: Base on local seperator for currency
		currencyFormatter.alwaysShowsDecimalSeparator = YES;
		currencyFormatter.hasThousandSeparators = YES;
		currencyFormatter.minimumFractionDigits = 4; // TODO: Configurable
    }
	
    return self;
}

-(void)createMenus {
		
	_statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	[_statusItem retain];
    
    statusItemView = [[StatusItemView alloc] init];
	statusItemView.statusItem = _statusItem;
	[statusItemView setToolTip:NSLocalizedString(@"BitTicker",
												 @"Status Item Tooltip")];
	[_statusItem setView:statusItemView];
    

    
    // menu stuff
	trayMenu = [[NSMenu alloc] initWithTitle:@"Ticker"];
	//graphItem  = [[NSMenuItem alloc] init];
	statsItem  = [[NSMenuItem alloc] init];
	statsView = [[NSView alloc] initWithFrame:CGRectMake(0,70,180,105)];
	[statsItem setView:statsView];
	[trayMenu addItem:statsItem];
    
	NSString *menuFont = @"LucidaGrande";
	NSInteger menuFontSize = 12;
	NSString *headerFont = @"LucidaGrande-Bold";
	NSInteger headerFontSize = 13;	
	
	NSInteger menuHeight = 15;
	NSInteger labelWidth = 70;
	NSInteger headerWidth = 120;
	NSInteger valueWidth = 60;
	
	NSInteger labelOffset = 20;
	NSInteger valueOffset = 110;
	
		//section header
	NSTextField *tickerSectionLabel = [[NSTextField alloc] initWithFrame:CGRectMake(labelOffset,93,headerWidth,menuHeight)];
	[tickerSectionLabel setEditable:FALSE];
	[tickerSectionLabel setBordered:NO];
	[tickerSectionLabel setAlignment:NSLeftTextAlignment];
	[tickerSectionLabel setBackgroundColor:[NSColor clearColor]];
	[tickerSectionLabel setStringValue:@"Ticker"];
	[tickerSectionLabel setTextColor:[NSColor blueColor]];
	[tickerSectionLabel setFont:[NSFont fontWithName:headerFont size:headerFontSize]];
	[statsView addSubview:tickerSectionLabel];
    [tickerSectionLabel release];
	
	highValue = [[NSTextField alloc] initWithFrame:CGRectMake(valueOffset,75,valueWidth,menuHeight)];
	[highValue setEditable:FALSE];
	[highValue setBordered:NO];
	[highValue setAlignment:NSRightTextAlignment];
	[highValue setBackgroundColor:[NSColor clearColor]];
	[highValue setTextColor:[NSColor blackColor]];
	[highValue setFont:[NSFont fontWithName:menuFont size:menuFontSize]];
	[statsView addSubview:highValue];
	
	NSTextField *highLabel = [[NSTextField alloc] initWithFrame:CGRectMake(labelOffset,75,labelWidth,menuHeight)];
	[highLabel setEditable:FALSE];
	[highLabel setBordered:NO];
	[highLabel setAlignment:NSLeftTextAlignment];
	[highLabel setBackgroundColor:[NSColor clearColor]];
	[highLabel setStringValue:@"High:"];
	[highLabel setTextColor:[NSColor blackColor]];
	[highLabel setFont:[NSFont fontWithName:menuFont size:menuFontSize]];
	[statsView addSubview:highLabel];
    [highLabel release];
	
	//
	lowValue = [[NSTextField alloc] initWithFrame:CGRectMake(valueOffset,60,valueWidth,menuHeight)];
	[lowValue setEditable:FALSE];
	[lowValue setBordered:NO];
	[lowValue setAlignment:NSRightTextAlignment];
	[lowValue setBackgroundColor:[NSColor clearColor]];
	[lowValue setTextColor:[NSColor blackColor]];
	[lowValue setFont:[NSFont fontWithName:menuFont size:menuFontSize]];
	[statsView addSubview:lowValue];	
	
	NSTextField *lowLabel = [[NSTextField alloc] initWithFrame:CGRectMake(labelOffset,60,labelWidth,menuHeight)];
	[lowLabel setEditable:FALSE];
	[lowLabel setBordered:NO];
	[lowLabel setAlignment:NSLeftTextAlignment];
	[lowLabel setBackgroundColor:[NSColor clearColor]];
	[lowLabel setStringValue:@"Low:"];
	[lowLabel setTextColor:[NSColor blackColor]];
	[lowLabel setFont:[NSFont fontWithName:menuFont size:menuFontSize]];
	[statsView addSubview:lowLabel];
    [lowLabel release];
	
	//
	buyValue = [[NSTextField alloc] initWithFrame:CGRectMake(valueOffset,45,valueWidth,menuHeight)];
	[buyValue setEditable:FALSE];
	[buyValue setBordered:NO];
	[buyValue setAlignment:NSRightTextAlignment];
	[buyValue setBackgroundColor:[NSColor clearColor]];
	[buyValue setTextColor:[NSColor blackColor]];
	[buyValue setFont:[NSFont fontWithName:menuFont size:menuFontSize]];
	[statsView addSubview:buyValue];	
	
	NSTextField *buyLabel = [[NSTextField alloc] initWithFrame:CGRectMake(labelOffset,45,labelWidth,menuHeight)];
	[buyLabel setEditable:FALSE];
	[buyLabel setBordered:NO];
	[buyLabel setAlignment:NSLeftTextAlignment];
	[buyLabel setBackgroundColor:[NSColor clearColor]];
	[buyLabel setStringValue:@"Buy:"];
	[buyLabel setTextColor:[NSColor blackColor]];
	[buyLabel setFont:[NSFont fontWithName:menuFont size:menuFontSize]];
	[statsView addSubview:buyLabel];
    [buyLabel release];
	
	//
	sellValue = [[NSTextField alloc] initWithFrame:CGRectMake(valueOffset,30,valueWidth,menuHeight)];
	[sellValue setEditable:FALSE];
	[sellValue setBordered:NO];
	[sellValue setAlignment:NSRightTextAlignment];
	[sellValue setBackgroundColor:[NSColor clearColor]];
	[sellValue setTextColor:[NSColor blackColor]];
	[sellValue setFont:[NSFont fontWithName:menuFont size:menuFontSize]];
	[statsView addSubview:sellValue];	
	
	NSTextField *sellLabel = [[NSTextField alloc] initWithFrame:CGRectMake(labelOffset,30,labelWidth,menuHeight)];
	[sellLabel setEditable:FALSE];
	[sellLabel setBordered:NO];
	[sellLabel setAlignment:NSLeftTextAlignment];
	[sellLabel setBackgroundColor:[NSColor clearColor]];
	[sellLabel setStringValue:@"Sell:"];
	[sellLabel setTextColor:[NSColor blackColor]];
	[sellLabel setFont:[NSFont fontWithName:menuFont size:menuFontSize]];
	[statsView addSubview:sellLabel];
	[sellLabel release];
    
	//
	lastValue = [[NSTextField alloc] initWithFrame:CGRectMake(valueOffset,15,valueWidth,menuHeight)];
	[lastValue setEditable:FALSE];
	[lastValue setBordered:NO];
	[lastValue setAlignment:NSRightTextAlignment];
	[lastValue setBackgroundColor:[NSColor clearColor]];
	[lastValue setTextColor:[NSColor blackColor]];
	[lastValue setFont:[NSFont fontWithName:menuFont size:menuFontSize]];
	[statsView addSubview:lastValue];	
	
	NSTextField *lastLabel = [[NSTextField alloc] initWithFrame:CGRectMake(labelOffset,15,labelWidth,menuHeight)];
	[lastLabel setEditable:FALSE];
	[lastLabel setBordered:NO];
	[lastLabel setAlignment:NSLeftTextAlignment];
	[lastLabel setBackgroundColor:[NSColor clearColor]];
	[lastLabel setStringValue:@"Last:"];
	[lastLabel setTextColor:[NSColor blackColor]];
	[lastLabel setFont:[NSFont fontWithName:menuFont size:menuFontSize]];
	[statsView addSubview:lastLabel];
    [lastLabel release];
    
    //
	volValue = [[NSTextField alloc] initWithFrame:CGRectMake(valueOffset,0,valueWidth,menuHeight)];
	[volValue setEditable:FALSE];
	[volValue setBordered:NO];
	[volValue setAlignment:NSRightTextAlignment];
	[volValue setBackgroundColor:[NSColor clearColor]];
	[volValue setTextColor:[NSColor blackColor]];
	[volValue setFont:[NSFont fontWithName:menuFont size:menuFontSize]];
	[statsView addSubview:volValue];	
	
	
	NSTextField *volLabel = [[NSTextField alloc] initWithFrame:CGRectMake(labelOffset,0,labelWidth,menuHeight)];
	[volLabel setEditable:FALSE];
	[volLabel setBordered:NO];
	[volLabel setAlignment:NSLeftTextAlignment];
	[volLabel setBackgroundColor:[NSColor clearColor]];
	[volLabel setStringValue:@"Volume:"];
	[volLabel setTextColor:[NSColor blackColor]];
	[volLabel setFont:[NSFont fontWithName:menuFont size:menuFontSize]];
	[statsView addSubview:volLabel];
    [volLabel release];
    
    
	[trayMenu addItem:[NSMenuItem separatorItem]];

	
	walletItem  = [[NSMenuItem alloc] init];
	walletView = [[NSView alloc] initWithFrame:CGRectMake(0,0,180,75)];
    [walletItem setView:walletView];
	[trayMenu addItem:walletItem];
	
	
	
	//section header
	NSTextField *walletSectionLabel = [[NSTextField alloc] initWithFrame:CGRectMake(labelOffset,64,headerWidth,menuHeight)];
	[walletSectionLabel setEditable:FALSE];
	[walletSectionLabel setBordered:NO];
	[walletSectionLabel setAlignment:NSLeftTextAlignment];
	[walletSectionLabel setBackgroundColor:[NSColor clearColor]];
    // TODO: Allow multiple wallets
    [walletSectionLabel setStringValue:@"MtGox Wallet"];
	[walletSectionLabel setTextColor:[NSColor blueColor]];
	[walletSectionLabel setFont:[NSFont fontWithName:headerFont size:headerFontSize]];
	[walletView addSubview:walletSectionLabel];
    [walletSectionLabel release];
	
	
	
	
	
    
    BTCValue = [[NSTextField alloc] initWithFrame:CGRectMake(valueOffset, 45, valueWidth, menuHeight)];
    [BTCValue setEditable:FALSE];
	[BTCValue setBordered:NO];
	[BTCValue setAlignment:NSRightTextAlignment];
	[BTCValue setBackgroundColor:[NSColor clearColor]];
	[BTCValue setTextColor:[NSColor blackColor]];
	[BTCValue setFont:[NSFont fontWithName:menuFont size:menuFontSize]];
    [walletView addSubview:BTCValue];
    
    NSTextField *BTCLabel = [[NSTextField alloc] initWithFrame:CGRectMake(labelOffset,45,labelWidth,menuHeight)];
	[BTCLabel setEditable:FALSE];
	[BTCLabel setBordered:NO];
	[BTCLabel setAlignment:NSLeftTextAlignment];
	[BTCLabel setBackgroundColor:[NSColor clearColor]];
	[BTCLabel setStringValue:@"BTC:"];
	[BTCLabel setTextColor:[NSColor blackColor]];
	[BTCLabel setFont:[NSFont fontWithName:menuFont size:menuFontSize]];
	[walletView addSubview:BTCLabel];
    [BTCLabel release];
	
    BTCxUSDValue = [[NSTextField alloc] initWithFrame:CGRectMake(valueOffset, 30, valueWidth, menuHeight)];
    [BTCxUSDValue setEditable:FALSE];
	[BTCxUSDValue setBordered:NO];
	[BTCxUSDValue setAlignment:NSRightTextAlignment];
	[BTCxUSDValue setBackgroundColor:[NSColor clearColor]];
	[BTCxUSDValue setTextColor:[NSColor blackColor]];
	[BTCxUSDValue setFont:[NSFont fontWithName:menuFont size:menuFontSize]];
    [walletView addSubview:BTCxUSDValue];
    
    NSTextField *BTCxUSDLabel = [[NSTextField alloc] initWithFrame:CGRectMake(labelOffset,30,labelWidth,menuHeight)];
	[BTCxUSDLabel setEditable:FALSE];
	[BTCxUSDLabel setBordered:NO];
	[BTCxUSDLabel setAlignment:NSLeftTextAlignment];
	[BTCxUSDLabel setBackgroundColor:[NSColor clearColor]];
	[BTCxUSDLabel setStringValue:@"BTC * Last:"];
	[BTCxUSDLabel setTextColor:[NSColor blackColor]];
	[BTCxUSDLabel setFont:[NSFont fontWithName:menuFont size:menuFontSize]];
	[walletView addSubview:BTCxUSDLabel];
    [BTCxUSDLabel release];	
	
	
	
    USDValue = [[NSTextField alloc] initWithFrame:CGRectMake(valueOffset, 15, valueWidth, menuHeight)];
    [USDValue setEditable:FALSE];
	[USDValue setBordered:NO];
	[USDValue setAlignment:NSRightTextAlignment];
	[USDValue setBackgroundColor:[NSColor clearColor]];
	[USDValue setTextColor:[NSColor blackColor]];
	[USDValue setFont:[NSFont fontWithName:menuFont size:menuFontSize]];
    [walletView addSubview:USDValue];
    
    NSTextField *USDLabel = [[NSTextField alloc] initWithFrame:CGRectMake(labelOffset,15,labelWidth,menuHeight)];
	[USDLabel setEditable:FALSE];
	[USDLabel setBordered:NO];
	[USDLabel setAlignment:NSLeftTextAlignment];
	[USDLabel setBackgroundColor:[NSColor clearColor]];
	[USDLabel setStringValue:@"USD:"];
	[USDLabel setTextColor:[NSColor blackColor]];
	[USDLabel setFont:[NSFont fontWithName:menuFont size:menuFontSize]];
	[walletView addSubview:USDLabel];
    [USDLabel release];		
	
	
	
    walletUSDValue = [[NSTextField alloc] initWithFrame:CGRectMake(valueOffset, 0, valueWidth, menuHeight)];
    [walletUSDValue setEditable:FALSE];
	[walletUSDValue setBordered:NO];
	[walletUSDValue setAlignment:NSRightTextAlignment];
	[walletUSDValue setBackgroundColor:[NSColor clearColor]];
	[walletUSDValue setTextColor:[NSColor blackColor]];
	[walletUSDValue setFont:[NSFont fontWithName:menuFont size:menuFontSize]];
    [walletView addSubview:walletUSDValue];
    
    NSTextField *walletLabel = [[NSTextField alloc] initWithFrame:CGRectMake(labelOffset,0,labelWidth,menuHeight)];
	[walletLabel setEditable:FALSE];
	[walletLabel setBordered:NO];
	[walletLabel setAlignment:NSLeftTextAlignment];
	[walletLabel setBackgroundColor:[NSColor clearColor]];
	[walletLabel setStringValue:@"Total:"];
	[walletLabel setTextColor:[NSColor blackColor]];
	[walletLabel setFont:[NSFont fontWithName:menuFont size:menuFontSize]];
	[walletView addSubview:walletLabel];
    [walletLabel release];			

	[trayMenu addItem:[NSMenuItem separatorItem]];
    
    refreshItem = [trayMenu addItemWithTitle:@"Refresh" 
                                      action:@selector(refreshTicker:) 
                               keyEquivalent:@"r"];
	aboutItem = [trayMenu addItemWithTitle: @"About"  
                                    action: @selector (showAbout:)  
                             keyEquivalent: @"a"];
	settingsItem = [trayMenu addItemWithTitle: @"Settings"  
                                    action: @selector (showSettings:)  
                             keyEquivalent: @"s"];
							 
							 
	quitItem = [trayMenu addItemWithTitle: @"Quit"  
								   action: @selector (quitProgram:)  
							keyEquivalent: @"q"];
    
    
	[statusItemView setMenu:trayMenu];
}

- (void)dealloc {	
	[currencyFormatter release];
	[_statusItem release];
    [statusItemView release];
    [trayMenu release];
    [statsItem release];
	//ticker stuff
    [highValue release];
	[lowValue release];
	[volValue release];
	[buyValue release];
	[sellValue release];
	[lastValue release];
	
	//wallet stuff
	[BTCValue release];
	[BTCxUSDValue release];
	[USDValue release];
    [walletUSDValue release];
    [super dealloc];
}

#pragma mark Bitcoin market delegate
// A request failed for some reason, for example the API being down
-(void)bitcoinMarket:(BitcoinMarket*)market requestFailedWithError:(NSError*)error {
    MSLog(@"Error: %@",error);
}

// Request wasn't formatted as expected
-(void)bitcoinMarket:(BitcoinMarket*)market didReceiveInvalidResponse:(NSData*)data {
    MSLog(@"Invalid response: %@",data);
}

-(void)bitcoinMarket:(BitcoinMarket*)market didReceiveTicker:(Ticker*)ticker {
    [statusItemView setTickerValue:ticker.last];
	self.tickerValue = ticker.last;
    MSLog(@"Got mah ticker: %@",ticker);
    
    [highValue setStringValue:[currencyFormatter stringFromNumber:ticker.high]];
	[lowValue setStringValue:[currencyFormatter stringFromNumber:ticker.low]];
	[buyValue setStringValue:[currencyFormatter stringFromNumber:ticker.buy]];
	[sellValue setStringValue: [currencyFormatter stringFromNumber:ticker.sell]];
	[lastValue setStringValue: [currencyFormatter stringFromNumber:ticker.last]];
    
    NSNumberFormatter *volumeFormatter = [[NSNumberFormatter alloc] init];
    volumeFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    volumeFormatter.hasThousandSeparators = YES;
    [volValue setStringValue:[volumeFormatter stringFromNumber:ticker.volume]];
    
    [volumeFormatter release];
}

-(void)bitcoinMarket:(BitcoinMarket*)market didReceiveRecentTradesData:(NSArray*)trades {
    
}

-(void)bitcoinMarket:(BitcoinMarket*)market didReceiveWallet:(Wallet*)wallet {
    double btc = [wallet.btc doubleValue];
    double usd = [wallet.usd doubleValue];
	[BTCValue setStringValue:[NSString stringWithFormat:@"%f.04",[wallet.btc floatValue]]];
	[USDValue setStringValue:[currencyFormatter stringFromNumber:wallet.usd]];
	
	double last = [self.tickerValue doubleValue];
	if (last == 0) {
		//no last yet so cant multiply anyway
	}
	else {
		NSNumber *BTCxRate = [NSNumber numberWithDouble:btc*last];
		[BTCxUSDValue setStringValue:[currencyFormatter stringFromNumber:BTCxRate]];
	
		NSNumber *walletUSD = [NSNumber numberWithDouble:[BTCxRate doubleValue] + usd];
		[walletUSDValue setStringValue: [currencyFormatter stringFromNumber:walletUSD]];
		
	}
}

@end