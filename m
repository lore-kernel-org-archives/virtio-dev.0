Return-Path: <virtio-dev-return-12225-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6142AC77B61
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 03:18:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AEA7341A12
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 03:18:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A6094986646
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 03:18:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9773398661D; Fri, 14 Apr 2023 03:18:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 85E32986601;
	Fri, 14 Apr 2023 03:18:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOw2ZidSBF9EU/xHHF8ra14JyIny80Tz0JJNi8wndQ6N4hLR/2rVwkbyov5DoEHlYob6yaRXgWBj6Ni/O27i2RTpXtVksm4tFRCBXAO7o2mXrN+QeJe57ud4F5XAs+I8GAb3l/BTzPrxTUhPE7bR+zTDDz+YWu4iY9VeadRPlEW0JnzmwF41fd6BI6qmb5z7dMTEKp+jz6PhzaQn/bzLiN999ckM+2dDjiwjjNsfNNnbfBak7GdXsj7Ol2M/J1JE+B59SNBOj9z0wbt3Skz1nshLAz+UMGbwQeXbrLNFUxWTdRm3KAwtcdC5X9G+g3AJmyvANISnlOZpwLfX8Vs7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvIk9s/+Iwk9Ad1br733N8jqa/YVXRM1aDU+bX5qy6w=;
 b=YE12zI/qg1RHAfWSqZi2OS5XCv4TYdJT6HMCCDNE2WW04TFZ+zTWAvqNSH/3CJLX+sY0TLf62k1FfrqEsn3LoE2ySeXbN1daSeoqX+aPfI//1InxM177ETypS1A0zhqtAbAzu6mi+qLV22G0ySnG43+5sJbGAal/PC4h548ZOz8duQFWNFutNueMPgGaU3HVJIBbiJUFQukDBXXFNOELg8wgtfXo1f+vh3dtUnKUZuy+FlFog9UBX2Dt+H8NeGEoY5MclDInu566zhKG0dDzSmEaZnzWbGMdCUeVMK7A0Ufa2OrethMZgOPNNqSaqqOkpq6l4pIJmwP7HTsExLjEtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>, Yan Vugenfirer <yan@daynix.com>
Thread-Topic: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers
Thread-Index:
 AQHZY1tLAUtRpuZtUUOucQPGJlFfkK8flpUAgAQ7nwCAAE6hgIAAAXwAgAAFegCAAAt0AIAALl6AgAEOIwCAAFEgAIAAIPWAgAAcJ4CAASFtgIAABJ4AgAAKJYCAAACFsIAABgyAgAAAT3CAAAYpAIAAAJIAgAAJz4CAAILBcIAAxPiAgAAc1wCAABy4gIAAyrIAgAAhEfCAAIO9gIAAAWdQ
Date: Fri, 14 Apr 2023 03:18:43 +0000
Message-ID:
 <PH0PR12MB548135CF5268D979A6D8EDE8DC999@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB548118F57BB4B4A4F8DC9D7ADC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvYsz1fSPG+fKpRaZ05Ut7ffKwvMPvR8xbRBsXA_6vGQw@mail.gmail.com>
 <PH0PR12MB548137D7A25C99EAA42B4D12DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshW82qztmGw8YJWJ8=QCoRd6cPxQ+ySazxsO_o+U6c4Q@mail.gmail.com>
 <PH0PR12MB548147CF939CB9C2A0586310DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu2B_GogDR9HUwB7mT8fkGh+Q_buPLz4nhwhK7h9k6BQQ@mail.gmail.com>
 <PH0PR12MB5481F0CF5A555A6BB2CE856CDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuNOYOxvcSzrs0UFEyk+xOkGUpOfhK8rOy_Mebz5b5wdg@mail.gmail.com>
 <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com>
 <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
 <20230413130326-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819A5D8FCEC6375D80897DDC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvSSXyXQnRs=OiaSJnSEYHP83chL6-B5ZPCGx6TeW9W5Q@mail.gmail.com>
In-Reply-To:
 <CACGkMEvSSXyXQnRs=OiaSJnSEYHP83chL6-B5ZPCGx6TeW9W5Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH2PR12MB4971:EE_
x-ms-office365-filtering-correlation-id: 311f19b2-d3a0-4b71-43a2-08db3c96f403
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 u/GdZE6usvJ1r96MfoFUaur8TOzGaQuQP/PgTbF+pb0gQWets8k7tpBKQtkdu82DwrWWmDXpIaBAuS/LD0q6Zf0b2rhdrTwbqYQM6S2BfHGHiFMvOPyWuzDjDXYMKpfuJRACZhYndbMj60ArLLlOZyW/XaApOhL4BB8WCls0nT8Z7Wup+8QN+QHpEw+RR51zesx0v/LO1R47upxS7K+ZGbOlZznSyaum/CBeZgU6mu/CqaeEiQ7cwNWKueS+Dr1P8h2lESCwTGvVFa8uo/FevcjtMoILFDw8JFgg+bxc5Ttv8npcYXQhvTeHZ0MObp30rFgNvaXoLvJFZ35w7Yy9rLsWv3828EXFrl285Zcrz912PryGovu6igZ8K1Rh8iWDkiboVwST8UOTLfxLmHBLIkuZvYk4nqjDiGNuL/4yqd/mn5OPw6TsLDRvU6U1DAk/9RSeGQ7/O6iRH3Vc2aUKrDYySS/HNvq+NC4L56IynO1wnGxK0tilbNSWMWP+7pYIDPPQsNU6ONNkQu/7Wn+gNhb5HOq1S9AchGeUYFGvwvadFUWcNWvqHmbmV54qLVE4oZTFr6DkonvfGx8wit6qxr/0Gp7t87A3qget1WyAwLvtVFCctTCXBPnPPLHI4xLz
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199021)(38070700005)(26005)(76116006)(66476007)(64756008)(66556008)(55016003)(66446008)(6506007)(9686003)(71200400001)(2906002)(83380400001)(7696005)(186003)(66946007)(6916009)(4326008)(54906003)(86362001)(5660300002)(52536014)(8936002)(122000001)(8676002)(38100700002)(33656002)(316002)(478600001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MmxDaG42T1Q2VlNTdHhzMTlkaFBJOUVvaUpST1JqaEFzclJCOWtNMzhBYnVB?=
 =?utf-8?B?ZFR3RDFOWklxVmhrUHdnMWpKUXZ6dGd6dm5EbC82RUFSS3pVSTJQb1I2Q2VL?=
 =?utf-8?B?UEw2L3JFclZwUjZ0WC8yYnc4M282R3V3VGUyTEtCelBCR2pJeXVKU0hEaW5o?=
 =?utf-8?B?d2lvajhKMjJFUEl3bStZa25zazVGZmhXSjFKdldKUm5JZWpWa0I2cklxMkk5?=
 =?utf-8?B?dlJUMnJxOHNZcmZIMHpCQittejdJVU1jeHVVa3Qrd3o5bjZxcjNHSnkwamNV?=
 =?utf-8?B?b29XWVFRL1RlKy8vb014VExuWWhaSVQwbjVHdzdDSDFaV1V2bVVlYmN5NXQ4?=
 =?utf-8?B?LzY0ZFZHdHh3anpjU3NuK2ZlME85bkpaeldmYlZFUWhMTEc1a1NTZjZmSFl1?=
 =?utf-8?B?bFhaK0NHM1BsUGM1ckRrM2lZYWQ2NTV6dlU5aWR5aEREd2FPRmpHelZlaDN3?=
 =?utf-8?B?akVZYzBKakdZWnJBRjdnS1lGTUxTZWwvanZneExaaFdwdmdBbjRqOUFlK0xs?=
 =?utf-8?B?WnFmR2FHcFl0b295RXNlRmNHMlJJZEpUK0pTUkcwWTEyYWxwRlNjL1NZcVNQ?=
 =?utf-8?B?QlhZb01EcU1HMFdRcEZCdnZIZFlpR1hqWGkvK3NuY2NzV1NwT2pBMERvYnFp?=
 =?utf-8?B?OFBqbkdRRlZ4dGJpKzVGZ1Ntc2VnYjRuSkZBcUdXckl6SGViVWkyeUJFa2xm?=
 =?utf-8?B?alFFdFpKN3ZvSWdsb2QrMDRSTjZvRHlhcnFIUnVkYUlxblZ5WVhVWGQzeWc3?=
 =?utf-8?B?bE83QTIxSVZZVHNtRkxrbmUrZVVWclkrM3UvTUVUU3E2cXIyeEMxL2thV1Zn?=
 =?utf-8?B?TzZZZFNsTFRwR2tvdVNta3EyUWRIY1o4b0FGNm9ab204dnhGQm94SFhaOXB1?=
 =?utf-8?B?eTVQNVJ2RFlDN1RMUS9nU3NnUXdGRjBZZVBhdzVRWmUwNm53Mmd4UjU2OTky?=
 =?utf-8?B?bVRnMGpYQitjWk9taWZWMkJTRld1R251TEU5c1VHNlFXS2czVkFtWGMzaENF?=
 =?utf-8?B?S1F6Rjg5aHg3eG1IQThLVWRWY1lnc1VDbWxYMzNndFJTQVZXTjdKRWdBMkEz?=
 =?utf-8?B?aDhPbW0vc1FtWEJvbmhZaG9lN1RNeXRwVDdqSHRzSGJzNUJKZXE5OWxJU2RJ?=
 =?utf-8?B?YWNobE5SNjlKQW5oOEtlaXRoZ1BFZ2N1QVIxQnh4M05rMnFOdWFLS1F3eDFR?=
 =?utf-8?B?V1I5bVR1MC9SdVZlbldLc1RqWVFhRVV6TFR0WXdERmFldjZqL1VTbTQ0RjU4?=
 =?utf-8?B?QXFGdmVYYUUxbHVMVnhGUW02U05CTjVBZ05YSlBiOUoxSkNNeUZqME5UcE40?=
 =?utf-8?B?OVZ4cDFQK1B2NUFXZFplNFFDSmZRL0tsZVRrY29yRSsxc3BLT0VXQUtvYXVp?=
 =?utf-8?B?TTVwRndOQm8wanFFV3J6Y0ovU1oyQm1lcjFiaTMzYVo1ZTY5TVhXa1lWb0Z1?=
 =?utf-8?B?NEJnb2wzaGlRQjQyOG90ZVYyNlRrczN4OEF2MS8yZENjUVN5SjhZb2dEVWpn?=
 =?utf-8?B?dU0wV3RaaTRRZzNYb1RNY2g1ZXM2cEtGNGliUTcwUHN4N2hKZHFNQnNzV3Bo?=
 =?utf-8?B?WkF3VjQ4L2hjYzdocGVqdFl4WGg0UjlWTVVWeFd6LzlGSlRPRXc3elB0b0Jq?=
 =?utf-8?B?bVU1ZU5qVVZLUnV3UENIY2I5RnVaQVV2ZnRub205WFh5anIrcDl0aW1DSWtq?=
 =?utf-8?B?UkQrSDlWT1NKVXRjUmViTDNvZXFyREJZckRRMFBIWVJDblZEVlJMTUlpTWlG?=
 =?utf-8?B?ZHJod0JndTQxMXJ0a0JZRTVORFRHNjUwVFNWaE5iMCt1K2ZpZFZCSUVsMWMz?=
 =?utf-8?B?UDZvTlZGRGRYNUswd2owQkY1MUMyZVZXRDBwK2cvYzlpb0JWU0JubGczU2lw?=
 =?utf-8?B?ZE13Vm84c0xxK3JuTGwwc2lFUlJOZEdTb2UySTJJN1JOTUhra2VFRFNxRzVp?=
 =?utf-8?B?Y21sZ2VnUzFEa1JYMnFCazYrbzlsSXN0MFpVbU1CRHdyeHArQWhKdGk1bFhz?=
 =?utf-8?B?bEMvcURHRU1zRm1uZDZCOVpDS1RIVHhkaUlSRUF2czNDUW9ySzVwQnRzZmVV?=
 =?utf-8?B?MElqWSsxa1N0T0dIeVltWDA4cjdxQXRqVXhianhNOW82TDlueTF5ZVNPNVBV?=
 =?utf-8?Q?7Uhw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311f19b2-d3a0-4b71-43a2-08db3c96f403
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 03:18:43.9420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UdC7bSrwS8Bx8FJc6RIQaAcdC3UZhdpTZ3/bK8KqpiT1ny1PHlKHpeOjoNSr97j1kpjEpd7c25ccVyi7rUaS6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4971
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIEFwcmlsIDEzLCAyMDIzIDExOjEwIFBNDQoNCj4gPiBXZSBoYXZlIHR3byBvcHRpb25z
IHRvIHNhdGlzZnkgdGhlIHJlcXVpcmVtZW50cy4NCj4gPiAocGFydGx5IHRha2VuL3JlcGVhdGVk
IGZyb20gSmFzb24ncyB5ZGF5IGVtYWlsKS4NCj4gPg0KPiA+IDEuIEFRIChzb2x2ZXMgcmVzZXQp
ICsgbm90aWZpY2F0aW9uIGZvciBidWlsZGluZyBub24gdHJhbnNpdGlvbmFsDQo+ID4gZGV2aWNl
IHRoYXQgc3VwcG9ydCBwZXJmb3JtIHdlbGwgYW5kIGl0IGlzIGJvdGggYmFja3dhcmQgYW5kIGZv
cndhcmQNCj4gPiBjb21wYXQNCj4gPiBQcm9zOg0KPiA+IGEuIGVmZmljaWVudCBkZXZpY2UgcmVz
ZXQuDQo+ID4gYi4gZWZmaWNpZW50IG5vdGlmaWNhdGlvbnMgZnJvbSBPUyB0byBkZXZpY2UgYy4g
ZGV2aWNlIHZlbmRvciBkb2Vzbid0DQo+ID4gbmVlZCB0byBidWlsZCB0cmFuc2l0aW9uYWwgY29u
ZmlndXJhdGlvbiBzcGFjZS4NCj4gPiBkLiB3b3JrcyB3aXRob3V0IGFueSBtZWRpYXRpb24gaW4g
aHYgZm9yIDEueCBhbmQgbm9uIDEueCBmb3IgYWxsIG5vbi1sZWdhY3kNCj4gaW50ZXJmYWNlcyAo
dnFzLCBjb25maWcgc3BhY2UsIGN2cSwgYW5kIGZ1dHVyZSBmZWF0dXJlcykuDQo+IA0KPiBXaXRo
b3V0IG1lZGlhdGlvbiwgaG93IGNvdWxkIHlvdSBmb3J3YXJkIGd1ZXN0IGNvbmZpZyBhY2Nlc3Mg
dG8gYWRtaW4NCj4gdmlydHF1ZXVlPyBPciB5b3UgbWVhbjoNCj4gDQo+IDEpIGh5cGVydmlzb3Ig
bWVkYXRlIGZvciBsZWdhY3kNCj4gMikgb3RoZXJ3aXNlIHRoZSBtb2Rlcm4gQkFScyBhcmUgYXNz
aWduZWQgdG8gdGhlIGd1ZXN0DQo+DQpSaWdodC4NCiANCj4gRm9yIDIpIGFzIHdlIGRpc2N1c3Nl
ZCwgd2UgY2FuJ3QgaGF2ZSBzdWNoIGFuIGFzc3VtcHRpb24gYXMNCj4gDQo+IDEpIHNwZWMgZG9l
c24ndCBlbmZvcmNlIHRoZSBzaXplIG9mIGEgc3BlY2lmaWMgc3RydWN0dXJlDQpTcGVjIHdpbGwg
YmUgZXh0ZW5kZWQgaW4gY29taW5nIHRpbWUuDQoNCj4gMikgYmluZyB2ZW5kb3IgbG9ja2VkIHRo
dXMgYSBibG9ja2VyIGZvciBsaXZlIG1pZ3JhdGlvbiBhcyBpdCBtYW5kYXRlIHRoZSBsYXlvdXQN
Cj4gZm9yIHRoZSBndWVzdCwgbWVkaWF0aW9uIGxheWVyIGlzIGEgbXVzdCBpbiB0aGlzIGNhc2Ug
dG8gbWFpbnRhaW4gY3Jvc3MgdmVuZG9yDQo+IGNvbXBhdGliaWxpdHkNCj4NCldpdGggUENJIFZG
IHdpbGwgaGF2ZSBjb21wYXRpYmlsaXR5IGNoZWNrIGFuZCBhbHNvIHZlbmRvciByZWNvbW1lbmRh
dGlvbnMuDQogDQo+IEh5cGVydmlzb3IgbmVlZHMgdG8gc3RhcnQgZnJvbSBhIG1lZGlhdGlvbiBt
ZXRob2QgYW5kIGRvIEJBUiBhc3NpZ25tZW50DQo+IG9ubHkgd2hlbiBwb3NzaWJsZS4NCj4NCk5v
dCBuZWNlc3NhcmlseS4NCg0KPiA+IENvbnM6DQo+ID4gYS4gTW9yZSBBUSBjb21tYW5kcyB3b3Jr
IGluIHN3DQo+IA0KPiBOb3RlIHRoYXQgdGhpcyBuZWVkcyB0byBiZSBkb25lIG9uIHRvcCBvZiB0
aGUgdHJhbnNwb3J0IHZpcnRxdWV1ZS4gQW5kIHdlDQo+IG5lZWQgdG8gY2FyZWZ1bGx5IGRlc2ln
biB0aGUgY29tbWFuZCBzZXRzIHNpbmNlIHRoZXkgY291bGQgYmUgbXV0dWFsbHkNCj4gZXhjbHVz
aXZlLg0KPg0KTm90IHN1cmUgd2hhdCBtb3JlIHRvIGV4cGVjdCBvdXQgb2YgdHJhbnNwb3J0IHZp
cnRxdWV1ZSBjb21wYXJlZCB0byBBUS4NCkkgZGlkbuKAmXQgZm9sbG93LCB3aGljaCBwYXJ0IGNv
dWxkIGJlIG11dHVhbGx5IGV4Y2x1c2l2ZT8NCg==

