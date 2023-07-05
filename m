Return-Path: <virtio-dev-return-13236-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8820EB64DD
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 13:02:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 13B5042A68
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 13:02:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 08CEE98680E
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 13:02:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ECC8098671C; Wed,  5 Jul 2023 13:02:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CDE6B98671F;
	Wed,  5 Jul 2023 13:02:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3pGnfvhqOugcg3PuehWVoTRx5hE4peenGSvqsl4A7pKbetVXE+y2h5C+nlHHAtsQRJk++lCqO2vAxR188mE2+D3vxRk64bK3Ub9K6Mx/UXf+wLTL76WaYixIOGjjkkRmausv2kG9jORf/KnMNlDaeFMrFrrXCHud5kaFqHFrV2PLEqUMDjJXc8xSWWksTv72JnhsaX8vk2ZAtBN/Fn3Yvs2bFOHwf2nfYeEspfXw9PCmXoMeAVzGgg+2qSz+0qrfa/wSXx3SQz4L0RzUTUU3bUTypWGSyWhWn+UZ2IpwDXeeC0ZmSOYCqg8huYEnHjrAQwZJo6MJFqqLbhuzJQxvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugXY4j7UfB+jULIkiZs1BtfpM+uxEh//WGA29TV+iM0=;
 b=L2DW7GM/iTbujW/9F7MRjsTiBWapdvZHn+hnkKuOydrC8CbpnUfR4zZD1I40AxYw2m5bg0bjOZJ0JBjJhVlBq6rBLQUfEqN7NdoDWqQhbhfTM+jiyx8H5CxUr7L7gkITWZMx43pxyTgaLQU/2Kf5x4P4lBX5W26b73M1qRMVCCiR/j1hetWepLja1Jm3BIAyyXz6zeQ8bWPpHZgHHtnM9e6rY7nNNlFx2lT1+qFMD9va0Djsp/EC09jCh9Zxg8K0D/fmqd/JF1eyuHiVwoCTzjwNrGYHM53vNADocvapqQtNd2LmWNvLtSY2vUzuGS7lnTmGk6YjRl8/IWUkhxP/gg==
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
Thread-Topic: [virtio-comment] [PATCH v9 0/4] admin: Access legacy registers
 using admin commands
Thread-Index: AQHZrtCLWAcU8k1wLESQt7niIKXarK+rBJ+AgAAdwiA=
Date: Wed, 5 Jul 2023 13:01:58 +0000
Message-ID:
 <PH0PR12MB5481B4761D5B67B850755782DC2FA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230704233724.22394-1-parav@nvidia.com>
 <20230705070758-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230705070758-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN2PR12MB4536:EE_
x-ms-office365-filtering-correlation-id: 88f019e9-98ea-44da-e3fc-08db7d58048c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Znsv3n43h6PPq862WpQ3eMOtrJ2+/vXGWbs9RhvMo6RJq7cp5FBIKFTiDmlfWAfE+pZAhOtNtVLEkECtVoIhL4ck70VkdKdLf1g/dXlsLZotIcUy8Mq9z5g+zHcXZt290DfTz9zN96NVqhG/hSmS1wauHl9jSGdrc9R/Lh+3R4wW9T/TW7Pt7e4+3Jo8T1SV5yJCY5slPhBGEtB1bMLibIQ/gRQxJIjsw9SiIRB04rJAxvutnbCSKEAMVdonWQpyqLsDoYBjmhDQORv7O7QxDp+2mYtps3dBCGo3i11wr7Tt8wstx04f2aEp1RDK/gQ/kgQJXELaD5KErr7eYsw7r7nm7rJECvFiZZUigwdHNbEGujx9VKke71r2M82h1T65XqXvr4tmkSw5mdOUQ3wMcCS51VaZ1Abhfs8Xk7mzq5CidRFadD49KQKrzLtxM91/p2u1/X9NWQdn/iVilOycIVMEAPPdNT0SuOFSMMoIjb6Ob4NaeZ18dGthxnR5vbvywWcFqGFRkHqbd4tVokRfYVAHOIKujhp8y0apCHWYqAB+kkq+iQTKSrp2Lnzfl2QVveICta92p6YyMtJ7rErFIUfloF6BFkC3k4iJWN/P9ZvKesstB+uzt3xGkLSp3GNI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199021)(316002)(71200400001)(5660300002)(107886003)(86362001)(66476007)(66446008)(41300700001)(66946007)(66556008)(76116006)(4326008)(64756008)(7696005)(6916009)(55016003)(52536014)(8936002)(8676002)(186003)(6506007)(26005)(9686003)(54906003)(478600001)(33656002)(4744005)(2906002)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WGwvUFRGd0I0bjFOMEVySkgzc0ZPNVV6bC9VTkZpSXh2Vk9WWlRuMVJjaVpn?=
 =?utf-8?B?bXhCWGF6dGlOR1dPQnlMWUxqT0RxMkpzdzlkdUxKenhZZ3NPcUtIRFZyMFor?=
 =?utf-8?B?MVV1cGFIeW5GeFExUmxZS054a2hRTk9sRXp5TFE1MjljdUl6ODBsK1huTml2?=
 =?utf-8?B?ZzZLZVYyZFQ4aWFpNU1MazhOM2o4QnZaN0EvVG1PM0lJRGx1ZTgxZFVRTmdO?=
 =?utf-8?B?dnpEbFVZV1hZOS94UndiaU9CdVNic09ZYy9NUEJ1Y3FmMSttUXRrTi8vWFoy?=
 =?utf-8?B?TmpGYUtvRHpEZ3pNL2gweEpOa3luVHhSVXlZc0g4Tk9Pay9rcXZCeFltV21L?=
 =?utf-8?B?Y1RONTZqTTRSZTVKV25hVHNudk5RaGlrZ2J4Q0hIRk1wQzBmWHRodjA3VUow?=
 =?utf-8?B?b2tBOUdoNFpGTEkwdHZZM3NIV1ZZZFZzMFZwV2o5ZXVYRTJUaWg4VTByQkgw?=
 =?utf-8?B?K1d2TzJjWW9HcVN1Y0JuVEQ1azVlZmJOOVpubk9ieTdIYkxpbmZPRVdZTGRK?=
 =?utf-8?B?cksxU2Y4MmZZanlMUG8zVzN4aWZEdWZicXBJUjJadGhTR2l3NU96akFmZW1s?=
 =?utf-8?B?bjI4eXJNR0Q3VnJZSFo5YUtNdXBNZTc5M25XMUtodUlEWTRjeWNYejZ3ZTZB?=
 =?utf-8?B?WE10UkpYWjlJMHhKRU44d3hkTSszS2JpcTU2Zjk3UC93Y1RockxKbUgvMmdn?=
 =?utf-8?B?dkF3ZUhDaVVXcmtHV2dLSFNMcWJERkl2S0Z4U0lLaXZEVjkrWTM0YVV3cDNQ?=
 =?utf-8?B?a296S01OS3lMNzJoNDl6Tyt4YitGZFllTStzOXhXTW5ZUVRuci94YzdjQU9S?=
 =?utf-8?B?emFsYUdyZDFlV25qeXV4WDRUSFJxd01jTi9icThaaDBZQzRNOENhSEMvMjlB?=
 =?utf-8?B?elhoY25pY2Y1ZGliMVJrOVFOT2FteFVwUkVyR21IKzYwR1BYdmRxM2l1SS9p?=
 =?utf-8?B?V0hUT084SlpIK2FTOXJtUDBhMTFoSW95S3RjZDBXU3AwRU1Sb0ZqektreTFF?=
 =?utf-8?B?ampNQWFmL01XM3VodTNQVXN0R1hMbnN0ak1JbXVLdC9ZY044WVB0VkR2azNu?=
 =?utf-8?B?ekFUVUhWVk1ycnpGdGV5ams4cVZiMEV6dmp6b0gzY3lEZE9YaHVjWGJ3Z2lt?=
 =?utf-8?B?RnNPVk9TWmhPWXd3T3AwbSt4M0lvcjNycnZ1eTcybUFmcTBGc1hrQU1Bdm45?=
 =?utf-8?B?dTdEK2ZvUGo3TDNYTWZldUJyRmVFTFh6U0dYaHNCRkF1UUt0a1A5V2kzSTYz?=
 =?utf-8?B?TTNSZkVOTEZmUG51UHV4MzlFMk15R1pRcStWNEkwektsOVp0YVFlTWp1dWZo?=
 =?utf-8?B?aVlYNEg0OUlnbFhMNmNsSmRRQzVRbFNGSnMxMGJrYm42UVNKcktNWDFaQnFn?=
 =?utf-8?B?V0dnV2VlcXdGSjFGQmxYS1MxcEtWZXZKMzRGUzVFUkd3VGhXZkxjbzFORU10?=
 =?utf-8?B?V1JLRW1PRmlWSmgvZndQRVVkMzNwZWIzQlkzTm8vbHp5aEQ3NktnRW5qcnZk?=
 =?utf-8?B?TThhSzdVNkJCL3A4aTQ2VXJlY1RIV2xmNGt1eTFwMlB2cCtkUXpIQlc0YmNV?=
 =?utf-8?B?SFowdVhBclRZRnB1aUM1R2xUZm11cFhoQzJKK1FnSFhrL2ZxK2pmcHNXNUlQ?=
 =?utf-8?B?VmVLWXVuUGgwZG9KMnhqYURtSUFuMjRPMEJSenhkekRNL0RPUU5iWThiWlAv?=
 =?utf-8?B?d1AwL0l1WFprSnhtSkJFSmpnZ1BaRVRXZUQvcWRwOFFUVHNLcDVZM0pXWU91?=
 =?utf-8?B?K3VPNHdNZjBpNUlPY0hSSTNkaTQrVHBVb1NrOElqZHJJdUxrb3dQbW9ES0Z1?=
 =?utf-8?B?WXk3N2FjenFQbkpKc2d4QmFRc0VTNlA5Qm1rVFBNMFJtaHdwYWNibWo4dDJx?=
 =?utf-8?B?NzFFbU0zWngyVlRGWllmL1BxRWRyMXNkS2xSa0JmTUhRcjE0bys3bWh5eHZO?=
 =?utf-8?B?RW1xWWt4TUQxd1IweW5qejlRVUZ5VkR4Y05JSCtxUHFvSXQ0OGYxV1crT1lP?=
 =?utf-8?B?Y3FZbCs5Vi9PMGVxVThpZDhWQ0FlRFB3c2JqVDg1dVBOMVhCMFJpMzk3OGtu?=
 =?utf-8?B?OTZOa1ZZVmZCdnhVNUdpREIxTzYwTi80UWt5VUE4cThsNndsT0JBMzBaMGlD?=
 =?utf-8?Q?nlI0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f019e9-98ea-44da-e3fc-08db7d58048c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 13:01:58.9551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZwYSpxXZDXyex0AiRKsBNu/1/ijWDiBGxZJVe9H75KBkGHeLINRRbZJLfbL/1WDobjsWCzuKB/wKqYDgpCua6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4536
Subject: [virtio-dev] RE: [virtio-comment] [PATCH v9 0/4] admin: Access legacy registers
 using admin commands

DQo+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdl
ZG5lc2RheSwgSnVseSA1LCAyMDIzIDc6MDkgQU0NCj4gDQo+IE9LIEkgc2VudCBhIGJ1bmNoIG9m
IGNvbW1lbnRzLiBQbHMgdHJ5IHRvIGFkZHJlc3MsIHVuZm9ydHVuYXRlbHkgSSBkaWRuJ3QgZ28g
aW4NCj4gZGVwdGggb3ZlciB0aGUgbGFzdCBwYXRjaCwgYnV0IEkgZmVlbCBpdCBzaG91bGQgYmUg
c3F1YXNoZWQgaW50byB0aGUgZ2VuZXJpYw0KPiBsZWdhY3kgY29tbWFuZCBzZWN0aW9ucyBhdm9p
ZGluZyBuZWVkIGZvciBpbmRpcmVjdGlvbiwgc28gcmV3cml0aW5nIGl0IG5vdw0KPiB3b3VsZG4n
dCBiZSBlZmZpY2llbnQuDQoNCkkgcmVsb29rZWQgYXQgd2VsbCB5ZGF5Lg0KVHJhbnNwb3J0IGhh
cyB2ZXJ5IHNtYWxsIHNlY3Rpb24uDQpUaGlzIGFsaWducyB0byBob3cgdGhlIGV4aXN0aW5nIHNw
ZWMgaXMgd3JpdHRlbiwgZm9yIGV4YW1wbGUgdnEgbm90aWZ5IGRhdGEgaXMgZXhwbGFpbmVkIGlu
IGdlbmVyaWMgd2F5IGFuZCBkZWZpbmVkIGluIHBjaSB3YXkgaW4gUENJIGNoYXB0ZXIuDQpUaGUg
aW5kaXJlY3Rpb24gaXMgZmluZSBhbmQgYWxzbyBzZWxmLWNvbnRhaW5lZCBzaW1pbGFybHkgaGVy
ZS4NCg0KDQoNCg==

