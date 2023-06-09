Return-Path: <virtio-dev-return-12911-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB307C7EE25
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 02:29:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 27E782AC4C
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 02:29:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2324998669C
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 02:29:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1878898668D; Fri,  9 Jun 2023 02:29:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0295598668E;
	Fri,  9 Jun 2023 02:29:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hohukrAd/Zh0zqDLW4XUfI/6ZGwnN2dYwPNu/3mlE9pU/o8g4f4FbQeJIeAzbfeLrqBsuDQdS0NPRU4PCJhMONtR1s5hZfWoiofq4rmn9ATy2VGUPXlb/PhsPrBLuWvdava/w+UhQ1oM16ksfg+h3eZIFPjVOudjAKEnKiPRHOy4C3FjtIo2CQxiUGKsk9QLwNmm4o7VgWqI38tBr8eqeMcSjWEP88W3Yqvi6YA0C/9DxX4Jx6OalsG1Dos3+bjZbORLeIMUUT5NzZ8CSe4Vkl5qpVJOrsLVHsbJ74I9b9W2namopgMhtL/iMt4vUJ1xSqOQE7dX4b/YNSEDwkKzPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxhU9hBX2AL9XxEkAadxQfsxfc3ey9PDQhqF3B+0EJo=;
 b=AuafYwJ7B7wLhJcwdh1ODsVOOaKqidUs9kH1kabcZkDXEGt0gEIKHwLD6T15/ATwMkZCiYzKc/0jW1ZY8T+0Hc+/+JhOtZ0SR0ptxETD9u27aE9u6V5rM84iA2cvGuUknYjGbbWxDIMuji+SFyCfBCBaPC7QXEeCJqVkLDeqgdJaMLO47sEVWw9PFJYj/VEJSGcg636n5elgs3DlKjxEu1+xFzFJMZ4xsJ8DDt6rF3bIoByfnBOS8URQuDQqlC5BOpb/wwRRSNGtKbMaPZZzMkzCVpQ9nHWHe5FkuOuPJQThUuwzFBNk8b3U35wo3YzpaWETjYqy7rqLkxSAIJFCVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>, Yishai Hadas <yishaih@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy
 registers access using AQ
Thread-Index:
 AQHZlZHqSKW+Shm580CRlUjcCTH7qK96p2iAgAAAjkCAAAV4gIAAAhyAgAAFe4CAAALHYIAABcIAgAAChLCAAHFxgIAAHa6ggABpWICAAHwV4IAACZWAgAAiwLCAAGU9gIAAAqIggADn3oCAAPNNAIAACTvQgABBawCAAhKfIIAAwayAgAAF5EA=
Date: Fri, 9 Jun 2023 02:29:37 +0000
Message-ID:
 <PH0PR12MB5481B197049376E7C4D0112EDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230604105027-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B721C34D85D63FCC1F3DDC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604174224-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481DABA25CA36A5460B13E5DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605014539-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C14D65D5E10CD23A9F67DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605092859-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CEB3A34AAB49A282F2A8DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605174755-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548180E16376862A3C0DFF1DDC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230606073544-mutt-send-email-mst@kernel.org>
 <CACGkMEv1so_KGwJZG3GnAf=JNky7+BMNK7N4NTtucDS+WyW5VA@mail.gmail.com>
 <PH0PR12MB5481D80A48F3BD82D86B3DB0DC53A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsVrqCGJJ2Q5OGbgPdtEJHTpvVt6nEKP_MzkSH_-cOa6w@mail.gmail.com>
 <PH0PR12MB54810313CA6DD1995F52745DDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsy=pG=LT0hOT-PO3HTkk3NOAu6qA_GaZpKwqq8B996cA@mail.gmail.com>
In-Reply-To:
 <CACGkMEsy=pG=LT0hOT-PO3HTkk3NOAu6qA_GaZpKwqq8B996cA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BY5PR12MB4244:EE_
x-ms-office365-filtering-correlation-id: f15ab055-4ed8-480b-0500-08db68915f38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vxllPI4howe1Vp6t+G7ktZBlptSTA1dSTyeeQyPjju60AYZJ0VtMJdwjEHwxLjgtOQjsuE8pMJnfbJeAfQsHGVJFODaNs81KOkQci9S6a1fb9JN+o7bynP0lUdE5mHAJauhk7KkfVryVd561rmeHc6ht2ptUg9hdFIXzay05RCfMUUx8XOtMP0K4XTkMXnpk5qnAkxsoo19uw9kc68EryYh/QEzVp5dSg/4pi/1gyefPVYncu4jfusdc4DFtv5XR4ly+Gqy3qZhgPx5DZRbNWoHqmywDjeAgO95C+jHRG4YX6AdyG4lp8cVLk0Sa7u2uQoPRS9NwfI2HJsY5jnxLt/PR3kiB7+fX+MTVWM+Qsc5PHJ8qEtZ3aZ7UldpM2J7WgrGNjIqcUerKZvBpKUAB13lh8yX3Hp5WWuzoHa2Jf87zlx897U8cnt6rEF29oQpQ3wann4f6STsbh5elB008H1dqrbI2mW/TPWhSrCuNA02KK7Rm787LcogCpoJNC3N07k4Llq0zMb2tPojgYuRFG4rBQRJf09DB5oLFpuhDkDotN9Ag6Msv0GKxQpndiPUg6ld4kky+CCPbcrvybUZghcapRdnR14PT+w20i2IXuUPvoI+LqQnMlOcjaB/KT3vn
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199021)(86362001)(2906002)(4744005)(33656002)(38070700005)(55016003)(7696005)(83380400001)(71200400001)(186003)(107886003)(6506007)(26005)(9686003)(122000001)(478600001)(54906003)(6916009)(316002)(66946007)(66446008)(76116006)(8936002)(8676002)(4326008)(52536014)(41300700001)(66476007)(66556008)(64756008)(38100700002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dGhPeFNDNHBRRlp3dVRuajVGbTJUdkg0cXhrVy9wbVdPSElsUVlQelhlWGdm?=
 =?utf-8?B?cC9ZY3hGMEQySHpDZnU3ME00OFM2NktPU3ZCUjRDS3pWa0dxN3ducWJmS0pm?=
 =?utf-8?B?RFFJYlZVOXA1MTZ6aDFDKzB1QWxXTy8zRGk3ZE9wY3VHdm4xa3dscm1zR0lO?=
 =?utf-8?B?ZHRnUm4wZkpWQTdIN1d2ZFFTcXlYRFdvaGNZclRLbzR0Q2c1WE5ES013b3B5?=
 =?utf-8?B?enZ2VTNpOEZycVZ3QXphOHFGSkVCSXZpU1RodkZwUDE3V1VqWGlqUEQvdldB?=
 =?utf-8?B?WmZHTkhzMGExaWtoZ1pTRnZRS3EvMytERzZwN3IycGRuaVRXOWM2aUdzT0to?=
 =?utf-8?B?ZU8vQndxN1JLUEVvck54S1dNdUpGWkhobnBYYVpORi9DRjBJb09kbTVneVM3?=
 =?utf-8?B?b1lyN09iR2ZIbWM1bDlZVlQ5KytUOVBHUGRURG1Td1lWbWtlQlJvcnRXYzJ5?=
 =?utf-8?B?S01MUHpkM29zTmNWcHNIUTBkUXRPWDcrLzY4QlR4Zlp6REh4dTRJUWl0c1Y0?=
 =?utf-8?B?czhZMUs5V0VCempuS2ZGcDREYUFmR3ZtdEdZb3hlQUhwRnlldFdQSzZ6UDIw?=
 =?utf-8?B?SFU0VjNLQ0pWcWVnNldMY0J6TGFyS2d1S2ZUbjlpeHZ6Yk5FdVIwNEhHVnJE?=
 =?utf-8?B?cXdVcXdySkJaeDF3SkJPOWd3cmthMWp1MDRwY3FUZG83UFBnYjYvb0tOVWtP?=
 =?utf-8?B?bktRUHZDT1pzbXk0dUU2dnUxbmxVNC9JOGhLWVpWeEk2WE5TSW1ldXU5LzVH?=
 =?utf-8?B?RDg0azQrMHV1ZjJnRVZ1eHdzUGNxbU9lNHFWZEhnRjNpRVhOYjlYMVQ0YldO?=
 =?utf-8?B?OWxFWXF1VFhRZmEvWEp4RkhqSmJHdDVrQXoyU2FlS2RPUnZxckd6U1hnRVYv?=
 =?utf-8?B?UUMyQWFraWwvYmNIbVBzT2RVNTdKcUl6TWFUaTA4ZXZpZGpVZ29JVTBuaUhD?=
 =?utf-8?B?R2VpU3lpNWdhOG5NVWw3ajhMelM4ZjRoQlpMWGQzLzNmbEd1SERUaHcvTEgr?=
 =?utf-8?B?YzFrU3lzNUU5S3VYQTlwRHZITi9XdlJJcDB5bzNDZ3MreHVzMWVOUFVoTGY0?=
 =?utf-8?B?aElla0Q0ZzBBSXRhTFdjczIxZ3d1TFJ5VktFK2J3VnFxSVBEbXpubVR1TjdZ?=
 =?utf-8?B?Sk9OUk10czV3R3gzRzVKVFhlWlFzclY1UlVQWklxeVY2bXowS1NoeWo5YUJq?=
 =?utf-8?B?QmtrUHZTeVBJallTcHI5dS9KcUJWWmNaUDhJRmZ3Q3RUaG9PSXNtYmJKamh5?=
 =?utf-8?B?eEk1Z1ZOODF5UHA0VmhueW5penFRWGk3cHVzZDNHaktUVXdUcWo2dEJCU1dr?=
 =?utf-8?B?dWhpK2VjeFhtSXJORnpPMm1uZnRldTJLcTg5VU1HeWxhYlh0RkQ3QUtNY1ZW?=
 =?utf-8?B?VE9FMGVzVE94RHN6cCs4ZWVmcE5FMHNMZEdqOTRsVFhWMDdJYWhQNWVBMTlF?=
 =?utf-8?B?NFUzeXIxMndGQlEvbGtFT0hma3pJY2M5cTVKOStUWEVaTmFTSHZQS2Y3TmJq?=
 =?utf-8?B?Tk45YVF3Q05SL0t6Ry84UHBwOTJ4andtcFMweG5vY2FJMHBGU0tuQkZ6ckZ3?=
 =?utf-8?B?RndjcTRGRWJ0YUU5WjhwUjAwZlliNlFoVmoxYWgybDVPRWxHb0k0aDEwWmtz?=
 =?utf-8?B?T28zcllmaTlXYng0MGZYSzY4V25Ick5CTWVHdlhaRHQ2bjJpVVZjVjZuNWp2?=
 =?utf-8?B?Njl5NTJRdU1CNDRMelVycWhkRVpqc2N2YkZSQjVkNlZFelM5T0ptWWo2eEJa?=
 =?utf-8?B?MGdYSVZSREVHVWtrS09OQlJXdU9ZWXd3VVZqOVJicmZBbTU5TXhZdkpmS0ZQ?=
 =?utf-8?B?clU2Vzk3MHBSWVkvWDJIUGZQMzEraFFtU1J4cmJ5ZS83TDVCZXR0MFQ5Zkxh?=
 =?utf-8?B?am5xVUtjb1ZSb1p0dFJ6V240MmRvUWU3Z0lkOC93TlltQm9PdnlkVkhBVlZn?=
 =?utf-8?B?Q0hWUUVVREpSb0xSOG90Y210YzBlMnpWd2Z4MW1iV0ozQmFZeFpLNUlSdXVC?=
 =?utf-8?B?aE84NnBRcWh2ZjlKTmZuZXpXS1JCNUM2dXZwMkNURG1CU0RuT2pzR1ZUK1ZY?=
 =?utf-8?B?aklrbmRDLzZTMngrNFBWSWQwVXgzellsbForSXp5S3p3b2pJUzZUbzVZYlVS?=
 =?utf-8?Q?najg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f15ab055-4ed8-480b-0500-08db68915f38
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 02:29:37.9861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wrIS0Pw8BAFvWOt6L1qvKJc+Pr1axmGfBsQ1Bpfeig0V4l7JSm791jNTB/m85jNli40Lqg5ZcQ0jRuhB21/O+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4244
Subject: RE: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy
 registers access using AQ

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBKdW5lIDgsIDIwMjMgMTA6MDcgUE0NCiANCj4gSSB0aGluayBub3Qgc2luY2UgeW91IGZh
aWwgdG8gZXhwbGFpbiB3aHkgdGhpcyBhcHByb2FjaCBpcyBiZXR0ZXIgdGhhbiBzaW1wbHkNCj4g
YWRkaW5nIG5ldyBmZWF0dXJlcyBsaWtlIF9GX0xFR0FDWV9IRUFERVIgYW5kIF9GX0xFR0FDWV9N
QUMuDQoNClBsZWFzZSByZWZlciBiYWNrIHRvIHRoZSByZXF1aXJlbWVudHMgb2YgY292ZXIgbGV0
dGVyIGFuZCBtdWx0aXBsZSBwYXN0IGRpc2N1c3Npb25zLg0KQW5kIE1pY2hhZWwgYWxzbyBleHBs
YWluZWQuLi4NCg0KSXQgaXMgcGFzc3Rocm91Z2ggZGV2aWNlLCBub25lIG9mIHRoZSAxLnggb2Jq
ZWN0cyBhcmUgYWNjZXNzaWJsZSBvciBtZWRpYXRlZCBieSB0aGUgaHlwZXJ2aXNvci4NCg0KQ2Fu
bm90IHJlcGVhdCBtb3JlLg0K

