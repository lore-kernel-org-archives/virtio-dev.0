Return-Path: <virtio-dev-return-13228-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2833EB64DA
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 23:39:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 683CF68462
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 23:39:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6299D98671C
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 23:39:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5389198408C; Tue,  4 Jul 2023 23:39:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3FFD9986637;
	Tue,  4 Jul 2023 23:39:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjslrOIrthnowA4uL6DVrK9CaMESAOrnMYTg4x7yFKkhWLNZX1vUhB40HfvzSFvKK6FsB++rwaBhf9PJ6aM/wFShmr1eicAwZlpzQ56yeivyLfG4r+0WD9aLNPiqmGdrnSBBbhRp/A6bf2PrsFxHw8nfIWHVS2zaNR+cqNbaD35wTK42udvp/jHT7VZJKvAg0xQHDtaSozIeQdrOBAjxd+dbri0kvXAtBLvwEdoNgc27o07V5tEBSSaXxlM+IwOLaY4pCny1BFKX8WWfo7bO1jyW8Bu6gH8QxxvVw7HhCteLNA0y5dmidTwCclRYWJrU9Rxf98c8j400weqCc0KlIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLcD+Xx3GBfbpHQ2r8+RkoOSd3s8HJQURqnOHR5Pr1Q=;
 b=Ybm+hv6mJM9FWT2QcqTntQQu2Fgq48o1NB599DVYEtz79zngcum4HKgeNiS6c1umF68SUNjiNAm0LkJZ42jXcKFNgm/OTSadhPT0wtPYTQ7Rd2sjlF8dRfbxxr5CmW9A2wNuVN5HWK80ZItoko/IGnmSB7IITXhobf1n5e8c0zf/O9pyHR38x2rK09Yx5rb5bzOjWoXgS/r+J7b8jJVC1C7B/xpx1NWY82rQBLLzxyYJl+cfqhmvApDkMkz0s61NeM9YOSGIi4ZT1dZuneS5W7rXekoWpj08trwCfNlJKfA0LnYv1kKT8FNv4VW0mEMu0sk5CCLV2n310yYuA9KDRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [PATCH v8 3/4] admin: Add group member legacy register access
 commands
Thread-Index: AQHZqwo9gupu6w0ua0ue/guTiCilX6+qL9oAgAAbLJA=
Date: Tue, 4 Jul 2023 23:39:24 +0000
Message-ID:
 <PH0PR12MB54812A2FA5A9AE3A4E37FEB3DC2EA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230630042006.1569920-1-parav@nvidia.com>
 <20230630042006.1569920-4-parav@nvidia.com>
 <20230704171700-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230704171700-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH0PR12MB8462:EE_
x-ms-office365-filtering-correlation-id: 89356271-8d97-4903-941f-08db7ce7e681
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hp356L7okwe61zZSrtIOOun0BRt6OYF6215hgmVzf3JoMG535gU6bSCUESaA24N/MVJhcik4+spPS1dnJdKHjnREDbT1i+9Z/h543uIX95h8BDjjx+iqcCEW2qUJtb6JwsYlbkjaTTKPmmYKAtrvAWyFirkVHAc7ibvMCEDgO6qxsMiavQuhjpwLk8G1eKD5FTsRxAMtC2rydT/Rjuq9VB7/0FCwJ6ET05acbz8Hb3QHQ6BaAFRi0dEbFXGDvGFUJlzd4dOdjajDSAIfqNCFDdjloAZWDzVhM3E0LQyIGW3eXo6zHdNRw8iTXwaW3jD410uIJz41Y5JpZK6LX5Oxnp8UIWOPEMYWlV2MAQ3+uU0mmX8w6ln9RwbabToN2SB3dwce4E6KqA6nWfhd0JO+6v+ovxKzj2wkgx8aMrCZvK22fb8oaHz36CvFeLAkIqJwbsHKl9yN4bkBXeun1r5Ku4uMuTHY7m42YYBpXF2ZtWD1rCFVr20Uw9rDwbAN1XDgMBosX6MF/AW43rcb4smMOOMEq4rJIwcYr3gz3b+Tg3w1ZLcPlaphbEDjJK7o0URuAJKX9mkQXQMBCTVKDq1qr7dEHlJAWcFPlDSnjogtuPSLtFuOkcWdRVuaj5MWerUH
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199021)(7696005)(9686003)(54906003)(478600001)(86362001)(38070700005)(55016003)(2906002)(107886003)(186003)(71200400001)(26005)(6506007)(122000001)(558084003)(33656002)(38100700002)(76116006)(66946007)(316002)(66476007)(66556008)(64756008)(66446008)(4326008)(6916009)(8936002)(41300700001)(8676002)(52536014)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UnBnUGQ5THlRZVJxTm02c2V3YkZsOVFGTWs0TDBleHUydFRXQzdHNkQxeVZR?=
 =?utf-8?B?V3lJdG1QUDUxdE12REUzanl6NWdoSCt5Z3BuNGVJUEZVVTVvMElveUN2RndS?=
 =?utf-8?B?TFF3SWw1aXQ0MitMakZkYTMrQm8rMmI2WmlWNmgwM0hzcTh0RXpuRjl2VXhl?=
 =?utf-8?B?UUNnM0pUUmxvc0pHay9sMWFVZUJqNDdDU3E0Rm0zZ0JMNjEzenhvekJRUWg3?=
 =?utf-8?B?WnJmVWU2dE5EV0k4bC9nNDQxTndzci9wVWJpM0xJbHJvRzBvMmlRL2NjbnZ0?=
 =?utf-8?B?UjZtS0l3cDRSdG93dkxHdWtPbWRwY0JHcUpCSmNGY0tQc2JnZE9LUHFJekxW?=
 =?utf-8?B?c2xOeDdpTnlTNzFqcXR4aXIxOHI1WUIzejNxamdSSDlQRXZTa1JscTZkT2FI?=
 =?utf-8?B?VlAybjBaNE5mby9ybk9GL0sxTFR2RkdoWVdqT1FMUUJSdHFyMEJRWFhRaG9w?=
 =?utf-8?B?c2hTNks2ZVpLS2lyc3ltVTNnaVRqM2lzeHF0eFVhai82RG16S1ZIWXQrMXNz?=
 =?utf-8?B?VzYwTS9aVTZTdjE0NnVYR3hzSUtJVXY1OE1YTThQeElBRFZ3dVBDQUEzZ3F4?=
 =?utf-8?B?VENCNlFLMVNZamQ1c1craDRoaEVxazhpaWlSWDJ3ODE4ZitvOTd0bTNQcVd6?=
 =?utf-8?B?RWZhOUp2NWJGVFZQUmdLekZMZ0xDaUd4STl6VDN6ckk2bk9JTzdTWmNacW0y?=
 =?utf-8?B?UUxITXhHVWJSdGc1NFJhaVk3V2JsMTFtQ0RodUhFL1dkT3ZRR3hSY3lsbzFE?=
 =?utf-8?B?a0NNZXduc015R1hrY0twU3NoVHhTd3RwL3FwN0Z1YWF5L0t4SFYreDEvUlVN?=
 =?utf-8?B?OUZiNHF4WlAyQ1pvalZpVVRidXRIbjBVdTZxTnJaV3dKbGtEd24rQ2h5cEtu?=
 =?utf-8?B?amtHNEE5MkhHYnpaYzZPaGtlbzFVRCtlZjRoMmIrZlFVUlE1UUlOaE1wVk1R?=
 =?utf-8?B?WDJFb2lDTkFKRW94QmorMGpKWFJmMzBzR01QU0tQTnJHNXhRam44Z1FHRTFP?=
 =?utf-8?B?M0ZDMnJzQ0lGdGZFVTc4OUpiWm8waGM3UFVaRzdkYkh0SVFtd0crZW1Ea0tV?=
 =?utf-8?B?TU1CYk1XT2hiLzhNejIzSUdHRmdOL1RKODJRSGRicFlROWdpbVFPUXVpOHFi?=
 =?utf-8?B?bzdveXowS0M1Q08wcm9GcmhvNVVpYm9lQnJsYm1Pak1CK3BTaGh5aFJSa0FN?=
 =?utf-8?B?ZGlUSG9UY1BBT2xNZklRdlBtdFpKMlpwcVdqemxKUUN6aE91YVVQTTgyUEpD?=
 =?utf-8?B?bGRMZzcrOEx0TUVDZ0pwbGRlUGdBK1lTSk9GYU1mYisxN2VnT2NyS0F0ODBH?=
 =?utf-8?B?Y1oydjBVd0NpV25YZ1RMZ29DSytEdVV1OXdadmE0TEZzUiswMHFYYUUzVGFZ?=
 =?utf-8?B?a21PNnl0bDNCUTRmT0dSUHZwMkYvS2pNRDdGcnpCeHlDSk5TaWJjOGVrbWZh?=
 =?utf-8?B?MWpmaHl1Q0R4NTFSSXZVREtPcGRYU0lkZVlKOUJsdDAvU0hsVzJhN1hFOW1t?=
 =?utf-8?B?RXBlc3VKSlRvb3B4YWlnZ0xHSmRJQ0tFUzk1V3N0eHFEaXRidmRCSDBpQW5R?=
 =?utf-8?B?Z0o0dHlhR0ZjVVVHRE1XeXFSNVZPVHRGck03cU1MbWFVMmZJWGVCK1c3NmN2?=
 =?utf-8?B?L2ZNbFpjeG9ISEVWOVRBbUsza1F2NThiLzR6d2M5eTFjdXdqeWhtMDVkQ3U1?=
 =?utf-8?B?MUorTHEwRUNiRmU4UER1Q2NFWVhNTHM5TVUxeTVYNnVWUlU0VEZ6L2Fld3FG?=
 =?utf-8?B?enBOY3dLd1ZpcGhYdUVmZVFhZ3hNNVdKbGhSaWN3cGh5ZS9LNWtqa1Rnb2dx?=
 =?utf-8?B?WTNPT2UzVG5FSWVwRjQ5TE1Sb2Q5bEFwdm55UTRUY1hWTlRWcVJrandXSUlN?=
 =?utf-8?B?N0FDVVh6RTdqczVWMkRiWVZjQUtBaVpvSHhCTlFUa1BSdlBtbElSMVNBOUp4?=
 =?utf-8?B?M0RYZG14YUxGVDllT2pQMEtFMFVDMGdaM0xNQ3gzeUJsbW1FSFpqOUY3b2JN?=
 =?utf-8?B?MlB1K3MwQW0xaStBTmhucXRlc1ROcHBrZTJKMWw1dHdpWndZK25pM253RkZC?=
 =?utf-8?B?RVFQeE9uNGlndHorbHBLcE5OQ2lBaWpTTmhCZlpRT3NiRTI3M2VNQjlETUJP?=
 =?utf-8?Q?2Amg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89356271-8d97-4903-941f-08db7ce7e681
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 23:39:24.9486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5QCGwXgYbDBJREN0gzWsWpsPh6SFsDiXqYiLfllcmUa38iLVFUGh31myD4ESIJUXKP58jr6gKMhW6ExjrZ9qng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8462
Subject: [virtio-dev] RE: [PATCH v8 3/4] admin: Add group member legacy register access
 commands

DQo+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1
ZXNkYXksIEp1bHkgNCwgMjAyMyA2OjAxIFBNDQoNClsuLl0NCg0KPiBHb3QgdXAgdG8gdGhpcyBw
b2ludC4gQ2FuIHlvdSB0cnkgY2hhbmdpbmcgdGhlIHJlc3QgdG8gbWF0Y2g/DQo+DQpDaGFuZ2Vk
IGFuZCBtYXRjaCBmb3IgcmVzdCBpbiB2OS4NClBsZWFzZSBjb250aW51ZSByZXZpZXcgcmVzdCBv
ZiBpbiB2OS4NCg==

