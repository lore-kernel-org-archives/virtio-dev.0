Return-Path: <virtio-dev-return-12917-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBF8C7EE2E
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 03:26:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9BEB32AC4E
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 03:26:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9076C98669F
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 03:26:01 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 819B298668D; Fri,  9 Jun 2023 03:26:01 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6D7EA98668E;
	Fri,  9 Jun 2023 03:26:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyiiAuaHHxi+ccuac8Fe7CBmmzFlO4mWEyPalfZWxyWuhjhs2Y52E5dtoxCE7dCj7ddeU+w7B657K2DrLcTxM8QRTIVVQfMv/VyRWzLyb4EAVKQlkG4iZveTbnUJGsfMoc3nPeB2Dg5YA12m4n02HfCg38mjWCdbz15A13PD40P+//a1NcftgKqIeOpTm3+p8LhKhtrTkBh9IpXxbk7lpiKssnWttouQ8/fsK/Cno9uw1R9WNuWx1qjMEKbQUZzUaiRl7f9UTvbaIm+6e9Ix90rRUXOIECfumbAkyTAaiPWYBpDmctE0vOnfBqbBr8dOV3r0cRgHOopMe3gWSyLv/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCVndBSoUXvKCmWkyBJC8G48T1w675QlF736ae4T0JI=;
 b=bbg9AxVMsa6ItnEl7NOT1jvgIZQThTwdNLx3ZgcpTD17dt6UolZPmEtArS65HlcZznPdew1hObNwLZotJsyeBSj4/6raSbdVsQMoNzauD+S1/06KS+P2ZXbjWeMcFHTAWjTTZgVfPpVR5tyleG+EMRUMBN2fv0y6JyKMaY3LoZX2IboE+43VzcxDKiqnURbaW3Y309jP0s6Vx8xXXy00UrCbdZtrCProWd8pLMPsHkeOEGReYtDZk+yyGeL513heVwDSZh7ihurXwXoGZwI6wN6S4pDLbBrqyk310aWMjawuw8FdFZLaWc+uxuzPlojT6kgADslQiIrHRr2hlBdBlQ==
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
Thread-Topic: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3 0/3]
 transport-pci: Introduce legacy registers access using AQ
Thread-Index:
 AQHZlZHqSKW+Shm580CRlUjcCTH7qK96p2iAgAAAjkCAAAV4gIAAAhyAgAAFe4CAAALHYIAABcIAgAAChLCAAHFxgIAAHa6ggABpWICAAHwV4IAACZWAgAAiwLCAAGU9gIAAAqIggADn3oCAAPNNAIAACTvQgABBawCAAhKfIIAAwayAgAAF5ECAAAQjAIAAAcxggAACF4CAAAAyYIAAAZcAgAAARXA=
Date: Fri, 9 Jun 2023 03:25:57 +0000
Message-ID:
 <PH0PR12MB5481175A9D915E3BF396AFFBDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
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
 <PH0PR12MB5481B197049376E7C4D0112EDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsPjwgx=atOC1ww+RnfJcrg7m2CmMXWQCCoreCwsWVpLg@mail.gmail.com>
 <PH0PR12MB54817C027CB2B7BB74BD35EDDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsGA4ZhOPn5OCTZEZkja2UrLpJ8DXH+d62Fp5rtdicseg@mail.gmail.com>
 <PH0PR12MB5481F1BE96B1CE71F4FBD2D8DC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu+LDKUkg5ZZjcRsztrL1QGY2a6wto8r93Ddwc6L=a63w@mail.gmail.com>
In-Reply-To:
 <CACGkMEu+LDKUkg5ZZjcRsztrL1QGY2a6wto8r93Ddwc6L=a63w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB7262:EE_
x-ms-office365-filtering-correlation-id: 536a95eb-a5ca-4b71-25cd-08db68993da6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 seA6cvYS+YluxxcJPT7F1Jbzqdm2V8bcUYf4odg+ODizZxHKieybn8xE5phfFUAbzVf6N7nzK7ySZq3PA4M/X8YYtDDgF1OFLFFyoZDyyTTkfhzy/CkYSz0m3SadC1TUTsz1/b2CIXjqxNtQXZbORthJjs6+tAeC6HwaSeNwYDdW+BoB5smUK3KeMRdYelFGy2mzmyRnl8rlKGRO3fnhxZJFbF5S8ek8t3+hf4qqkYZGUJgcyKf9X/2d7jMwV/xneinFqwIJR/vCRIB9CMMcnzpPObu5xTqGgQeePPZEGsOR/koeixPn6D6tccL/1/SWsQoISRFVMsT1tC6BH8+4JFuR+mq0a5vbL8X8b7XFnxSya2t7o+vvroXsX64V4GnR6HozjODZC26ikYAaDQurJdivp20Bl2OpXNHM1OLOrHBLIHqagR6wvffqPxFmaJ9Sms61SgvrtEQjs2kYzSa7obGPNWegINDFEWCkCPRKuaJDDGAuqDuRxREezE764l/HPQ6+cYCuTdMGGvRpNWYbuyH4ss+JySzjOr4MV9MTs3WLZLv7GFPZOu/q3acwwteIvRsNdI3mpPSXWvT7icsXao7nwRGN/9m2cyzILWlM4Ns=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(451199021)(55016003)(54906003)(478600001)(8936002)(8676002)(6916009)(4326008)(66556008)(66446008)(66946007)(38100700002)(316002)(66476007)(76116006)(64756008)(41300700001)(122000001)(186003)(107886003)(71200400001)(83380400001)(9686003)(26005)(7696005)(6506007)(33656002)(5660300002)(52536014)(86362001)(2906002)(4744005)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YmVvTlNCZ2JvS3FrK2h4ZzNPWkhJTjBkUUErdWcxa1JiV0JTR0FmVDJJN2E5?=
 =?utf-8?B?ZldweEZocUpVWVVlT1dNYVlpUi9ISVZaS21nUTRuZXgxVnBCZFNXRm5DQ09D?=
 =?utf-8?B?NHJCbTkxZFVvQmtocFBJSkJXWmsydm9QNUJYejFOODZDN0pUV040YjBiQ2Nh?=
 =?utf-8?B?Zm41U2JxK0VCay9kWmpHUmQ0NC9icXZPUnFKZDRQMllNQ3dHcEU0aTBjWmV1?=
 =?utf-8?B?SzFudERPRWt3ZnNpTE93eWQ4R3lMb1dvclE3ek4xQkhyOVIwazZFZ3granhW?=
 =?utf-8?B?MXI2bW9ObS9vOXBmUUVTV0R4eUtVQnVTQzh6UFZ4Y2l5eTNCUThyK0ZtdFcy?=
 =?utf-8?B?QnViaUxuT3d4cmZMbXpOdW8xZ0QycVRuN3BmSHFVOFFqQmlHYVlPTHBPcC9t?=
 =?utf-8?B?S0lGdEVJblNsTkdSRmllYXcvdnZBNnFLakVuT1NubDgzRkVkOWpJcGpGMWk1?=
 =?utf-8?B?TnNDaEtDeloxc0RBQno3bTQ1Yi9xaU92QTVaQTBveUYrUmViQ25hMTgvVE1w?=
 =?utf-8?B?NnJXUWZsbjVuYm9QV0pTQXdtWEpKSm5lL0YzWWdqNkdoM1V0SDVqNUpHcDZu?=
 =?utf-8?B?Nk9Nb3FRbVZVbkNkTzl1UE83WktvUG5pS29rZjJ3ckxZcGZNVy9XUnBmaSsr?=
 =?utf-8?B?UFExVHlqNTdkKzZsRURock1vM3BwU0pRWFMzNTJDdWRKeGxMVmRPUGtZN0R2?=
 =?utf-8?B?NEJRT0tFeDRPYk5UNHFDZG8yLzl4NUpwSDl6UGFLMW8yUk9ZUVQ0SVB3OHdR?=
 =?utf-8?B?TUlKSlc5WlBuRUlISVZJU1lNTHN6dWxBb3UxOVQ0TjFkd1h0SzlBWEJ6eS9x?=
 =?utf-8?B?bWdLVWlqK0JONjQwMUQxV3pWbitkWjg1Y3VzNFZzcXdiL1d3a3BuUk1yOGhG?=
 =?utf-8?B?NGdIb0c4YVBOazV4bkpaRXVVNEdiZjZOWExoMGkvdkFvWHMvVUwxN3Y0U0Y2?=
 =?utf-8?B?YVdzOGdKWStHQmRHTlhhclJrWG1ob0FLZUduRDBtZVdtQWg0ZW9ZRzgwV2ND?=
 =?utf-8?B?MnFDOU1pcVAzVFAyN3dhU1ZaanNUZTRtblBLK0RsbzQ3bE1OaGpWSUlyb3Z5?=
 =?utf-8?B?V1VrMVplQngyeS9XdGVhcW9HNzJlbVpNamY1cjlOeDF5QzJGNUlWSlRoTlc3?=
 =?utf-8?B?SmVwcVYwc2V1RHNoZGdOZG9NQTY4d08zK0pjMVVUSGdnTjhIS2dsd3BjcFl3?=
 =?utf-8?B?RnlGUGltWG82ZjFiOUQzUUVvc1NlbXJiSjJTNXJDcVZTREl2Sm5XdCtrL3FO?=
 =?utf-8?B?ckt1U3JWWDJnMVZXa0M4NkUyaXJ2ODZZNGpEQzRzOUtUR09WT2VGbGlwQjlj?=
 =?utf-8?B?Y1pYMjZLQUc5VnNTYU1CbDBCdXB5cmNremJVNkpLVEpUYVRiK3phY0x0T2RD?=
 =?utf-8?B?TlZRMHo0TVJ6Z2xwZXZnRlN3eDkvYTNYR016cDJtSU43WDZOdGtBRjVsVEdv?=
 =?utf-8?B?YnYvdlBLVE5NY2w0NE1xZTBNTS9RS3FTZTFkY0I0T0ZiRnJBMngzY1Q4emQ2?=
 =?utf-8?B?V3ZCZHVkdFg1TnhaalFKSnF6eGlXaHNMbTV6ZklROGhoOE9YNFUyelV3NHh4?=
 =?utf-8?B?Ukh2VWhZNStVNjVMNEtZRzZPRlZTbTRTM2JBYzFFcFd6S3BSODgxQXFQWHNW?=
 =?utf-8?B?clh1RHJSZVExWU1vMHRCUmxmNjliQVlzb2tDUnJSRnovTXJPRVhxOHN6MEdw?=
 =?utf-8?B?eGE0M05kdnREMkpEK1grc3MyYW5vU21DanY5MkFRU0tRMTQ1VDhSd3pDdlpn?=
 =?utf-8?B?ZFZMakIwQ2xrMi9QUk9sR3B6TyttNlkxNmQvRU5FZmQ0WmpLNzJxRU1FaEgx?=
 =?utf-8?B?T21YZFBFaU5KMWdYRldkVG9UcVhubUZoTTNFR2x4L1F6OTRLNVZzeHhidHVU?=
 =?utf-8?B?QUtzcUVmQjRIWkpOVFRvOXUwVWlhU1k4RndVNy92RDVqQlRKcVB0ZGNQTUow?=
 =?utf-8?B?OFdQS3E2K0Y4aEFtWkFpZERIOWdoZzB6SVdvWktKZm02SGZLZ3hPYjdsWlV2?=
 =?utf-8?B?bW94b3dCQ0xJS2lRWERkbDZCQmRHcWNKUy92WkdNRmlxRGZzeWdiak13eHZl?=
 =?utf-8?B?cDhSZ1ZIcU5QdEVSOXhBMXY0b3N5NVJCbUtqYWpUeGVWZkRHaWgzQ2Rmd25I?=
 =?utf-8?Q?nzMk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 536a95eb-a5ca-4b71-25cd-08db68993da6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 03:25:57.6138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pcGSNTLqzB8743JZ98zH+nk0ljaS7q+jMQl26xIyfcCwxnvQ3ojnA/foiAeRL+y+U8IwC9NYEZPtYRXI5Vt/VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7262
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3 0/3]
 transport-pci: Introduce legacy registers access using AQ

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBKdW5lIDgsIDIwMjMgMTE6MDMgUE0NCg0KPiBXaGVuIGxlZ2FjeSBkcml2ZXJzIGFyZSBk
b2luZyBmZWF0dXJlIG5lZ290aWF0aW9uLCB0aGUgaHlwZXJ2aXNvciBtdXN0IHRyYXAgYW5kDQo+
IG5lZ290aWF0ZSB0aG9zZSB0d28gZmVhdHVyZXMuDQpEZXZpY2UgcmVzZXQgdG8gYmUgdHJhcHBl
ZCBhcyB3ZWxsIHRvd2FyZHMgMS54Lg0KDQpBbmQgdGhpcyBtZXNzZXMgdGhlIDEueCBmbG93IHdp
dGggRkVBVFVSRVNfT0suDQpNb3JlIGNpdGF0aW9ucyBmcm9tIHRoZSBzcGVjOg0KDQoiTGVnYWN5
IGRyaXZlciBpbXBsZW1lbnRhdGlvbnMgb2Z0ZW4gdXNlZCB0aGUgZGV2aWNlIGJlZm9yZSBzZXR0
aW5nIHRoZSBEUklWRVJfT0sgYml0LCBhbmQgc29tZXRpbWVzDQpldmVuIGJlZm9yZSB3cml0aW5n
IHRoZSBmZWF0dXJlIGJpdHMgdG8gdGhlIGRldmljZS4iDQoNCkl0IG1heSBldmVuIHNldCBiZWZv
cmUgc2V0dGluZyB0aGUgZmVhdHVyZSBiaXRzLg0KSXQgaXMgdWdseSB0byB1c2UgdGhlIDEueCBz
dGF0ZSBtYWNoaW5lLg0KSSB3b3VsZCBsaWtlIHRvIGtlZXAgdGhlIHN0YXRlZnVsIGludGVyYWN0
aW9ucyBvZiAxLnggZGV2aWNlIG91dHNpZGUgb2YgMC45LjUuDQoNCj4gV2hlbiBtb2Rlcm4gZHJp
dmVycyBhcmUgZG9pbmcgdGhlIGZlYXR1cmUgbmVnb3RpYXRpb24sIHRoZSBoeXBlcnZpc29yIGlz
IG5vdA0KPiBpbnZvbHZlZCBhdCBhbGwuIFNvIG1vZGVybiBkcml2ZXJzIGNhbiBjaG9vc2UgdG8g
bmVnb3RpYXRlIChlLmcgdHJ5IHRvIG1lZGlhdGUNCj4gbGVnYWN5IGZvciBMMikgb3Igbm90Lg0K
DQo=

