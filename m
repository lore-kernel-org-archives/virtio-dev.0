Return-Path: <virtio-dev-return-12261-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502E8C77B7C
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 17:23:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9255160379
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 17:23:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 84D1D9863E3
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 17:23:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7787B98634A; Mon, 17 Apr 2023 17:23:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 63694986353;
	Mon, 17 Apr 2023 17:23:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOHanutRDN5HNkQ2FTErlp08uGOJCt+f6d84OzsYK9cA6bJGKnhGn43VwjAAb3dSrZ5FleNFAbwJndNwoFbDvFBjAYeNu11V/R1gZvX9yCqwj07z+9/jCurtLxOUaDhflgrecCHMbTIiW69CE6r2/iY5nRns70E1xtTIOjq35teKaudGXu7HcfgpYwfsw+cXp/9i35HW8Q2H383jML+wEF+PC1nI8p8qAzXAiDZfI/8wea0/BfXUo6NctPu1OyKs/zuHt69pcTZnq7TN36O5kfRYIbV0kIiu9svv/XEV1sFdH3ZRUVX+7SZRuL6Mc3uh0vLP0h5mjdNzP6nVIeE42Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3t82ulI3TyuzaoPQqn66GIpyF4qjyU4ztJ+7Vm03eE=;
 b=oP9sl4lXzC2Ra5RK7ThySZSdT5+OSVi12TIADFZOIFVOJWYw2Vaz43+VAzZaLA2vJf/KOQZhYYW399dclhN93pHYxaLjAmdfD23tgryZDenQJ9hmfzaubxpP5y2SgjPVmGJiAer+/B+maALcYtmXITRuBDLnjhX/YpfaA5NrMqY0vxsU3J/ZrhZ0NaEOMii1Xq5s5ZGVwd+0Td/yqAah8Hb+TijfBZmRn630pRK+EgQmYnCikWDOHx/xUcKyIJHyKw+MB7rR3X6dqRRZxcwbkWkVO0oDFywRjoXNN56XnpQkRUmj2yLkmfBa7Bo4v0Hd5y1LF5pC1OxpMaISOjesGQ==
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
 AQHZY1tLAUtRpuZtUUOucQPGJlFfkK8flpUAgAQ7nwCAAE6hgIAAAXwAgAAFegCAAAt0AIAALl6AgAEOIwCAAFEgAIAAIPWAgAAcJ4CAASFtgIAABJ4AgAAKJYCAAACFsIAABgyAgAAAT3CAAAYpAIAAAJIAgAAJz4CAAILBcIAAxPiAgAAc1wCAABy4gIAAyrIAgAAhEfCAAIO9gIAAAWdQgAAGhACAAACJcIAEsiqAgADky5A=
Date: Mon, 17 Apr 2023 17:23:30 +0000
Message-ID:
 <PH0PR12MB5481FFC95F54AD048927FF12DC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
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
 <PH0PR12MB548135CF5268D979A6D8EDE8DC999@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsHtC99kTTa0TrfeJuhV+F7e-WF7XRgbLJkCBQeAxW8pA@mail.gmail.com>
 <PH0PR12MB5481C29561D5E48BA5D8AEEEDC999@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEseO=4xDA+pH2x=CaJ6XyzHEx1ZFO-+uevJH50kLeSWhA@mail.gmail.com>
In-Reply-To:
 <CACGkMEseO=4xDA+pH2x=CaJ6XyzHEx1ZFO-+uevJH50kLeSWhA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH0PR12MB5388:EE_
x-ms-office365-filtering-correlation-id: e5af4931-9715-41bb-98d2-08db3f6876b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 PjLloEdyVQOiebxg47diyMuAtJWXUeA0RZvbf3+JyH8PCubM97G3Dsn45KlH10gJQpNoHNWXcszIJi7zETWrV1Idc8xDPGkXV56jWewR/uV/1T5zA85vCyA9gENcriDhLjxHFnyZCFJq7Cf08RgG7DeEAXu9emxXEuzM/U6jC/cIo/aAobSbBbcH6X5VpugNfo+HwHR2WrWIK4zH5U1zzftpNOZCnkOJ/hVYzvBIQToEpPT8jcC07MrqKtGxEDQDeMNPQJ1RaLOKk/Hut1YJjgiLvxET1AEz7eUsXLW6C6nXSYrBQMvALQkJBN8hIIxr+e/nzKshVwe5YQGxxB/lGgGiKHD3y0hD1H5/xIzEZ2zJ7/kiE9vTz7qSgONsA6NBffD6VCrx72WIe5aWUKtt0Y4TfW2QjwuGJcmrnC5AOKAIy26+/egtynYY1C5KDTXChaMUrXftA66SVxN1iH+QcWKyKXD+pHGFhJnj9eotkTfDztiqjuqzpT5lQ62azqOeiMpMp/44iSUtmuQBKlGjoCDVd/UZ6WoPYkFfOO0nATwhoXSQzLWIK3mjmGve3qiQV9+s/qDJka4+8wV0CJ5DovZ/MrQrYFabbPPpyumAoKawpsCBJB2yoYwCBuZSHVyy
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199021)(76116006)(83380400001)(54906003)(186003)(6506007)(26005)(71200400001)(478600001)(7696005)(9686003)(53546011)(122000001)(2906002)(38070700005)(52536014)(8936002)(38100700002)(33656002)(5660300002)(86362001)(55016003)(6916009)(66556008)(66446008)(64756008)(66476007)(41300700001)(316002)(4326008)(66946007)(8676002)(66899021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Sk04WEhkT1lPSWdodElhVjZuVjZpVmxVcGVJNXJuZVNvVFRWdFZiOWFGMDNX?=
 =?utf-8?B?RkNkbjNUamdnTnhXMXZlNklES09HcXh5bmVRb3N3elFPVllOWjJvZWxHT09t?=
 =?utf-8?B?SHd4RENiR211LzZ1clVIRVZDQm5STk5yN09nRSthZGRPUGJUUW12eHcxbGVM?=
 =?utf-8?B?RU5kQ0FuUzdPYXkwbXNmV0V2dXBrOTZLT2NzQ0xWa251S1lEVEIzUDltOHhF?=
 =?utf-8?B?aUNiWVZBUGFrSTY3ZXFxNzREd3QweUlDKzdEd2VSQjNRM3RNQm1pVHh3eVFh?=
 =?utf-8?B?SnZnQXNaM0NYZlBSNHgxWi9FbnMydDlsMkd1R2FaaDRoRDdtSWVlRkJLN2FM?=
 =?utf-8?B?UXVrZkU0aXFrUEExWTMwUWZmbWNtZHluUnZiRDlZd3ZEWmdxclR6cnFWN2lS?=
 =?utf-8?B?M0tDcURPTHlYc1BjQ01pTVIwUHlTS2lGQzBsdlRWcjFRQUNEUGd0aXJWZGNh?=
 =?utf-8?B?R2RsOXdPUGl0TE96aUhzdE5DNTY1L1Znd1hMSWhiT3loVnRBVDlpUmVuWHFM?=
 =?utf-8?B?cDU4R1d1dVZXR1BtNHg1aW5rWnRUR2pBYTBZbTUrQU9kYURJWWE5eHBRYVMx?=
 =?utf-8?B?Z1UyUXd6SzVmQXlyeDhUVVVsTGxoandNNElLeGx4ODZlWUJISjA1b1N6QXlj?=
 =?utf-8?B?K0V3ZHliOFc1OW5ZNmRhYVY2MCtkNWQya21tbmJ0THZTbENxVStORUFEMDNz?=
 =?utf-8?B?RVV5TTlCYm5SRWROcHlqNXluc1kyc3JUcXBlUlhCNTVKbGtOZ3FocDdvM1JK?=
 =?utf-8?B?UExwRUJKUFhsMFVHUktrS1hvaGtYK0kxeEFmdWx5d1luSjBtVE9Bdnlsejc3?=
 =?utf-8?B?K0tQMFdRcWIwYnl6RWNrMTZneERoOUJoMGdzRFhPc2g1elQ0Q0F6VnNmWEFL?=
 =?utf-8?B?VTBEeGEzNGNzZ1hiN3lVYWovY0VxdURLNUozSVFOZnUzMzg3OHJGYUxObTk1?=
 =?utf-8?B?bWNnMGdKQlJBMlVQanNzaGVzWGt3azFVUzd3YkZVTUZsZGltVmxWMlNPQ24y?=
 =?utf-8?B?ZkJFTHhIc25qK3RoUGIvSEYzdG00YVhsTk9MTE96RDc2N21BRituaWJaVzRn?=
 =?utf-8?B?dk9WU1RIMUwvenlQVXEzTXJPSjJIRlJmMk1OeWZ2eHpOcyt0dGdKZXllNG1L?=
 =?utf-8?B?Z0RWcGZIVHRLNlM1aEN1bmFIaHNuN3hkUERjV1pZWE5teWhjYTZQRGpia0lL?=
 =?utf-8?B?bjlMaHZ3cnBIOEZZazVpK0g2TGUyTzBoSzZrVExkSHB6dTBzYmZ5ZjM0eWZZ?=
 =?utf-8?B?UDhLVWQ3enBXUnladXZZZlNzazhLS3pFQndqWG5wc0NMdmlLcVVUR1g3cXh2?=
 =?utf-8?B?ZlJzY3lxaUZnTFllNnRjOThPRy8rWTk4THdFeVRoRmpqZlk3WHNZK0RXSkdm?=
 =?utf-8?B?SkgvbzFiK0huWit3VEJXL3BKL1RhM2ZhUTF4cEJucGdlRjk3enV6dVRJSjZy?=
 =?utf-8?B?eG1jRTBsdUZpQ3Uwa0JwN1lwZWtiUlBNN1NUR0tab0N4OXBqVXFYOW1DM2c1?=
 =?utf-8?B?OGtTTWdEWmhScGhPcC85TU1ma2ljdUFhSnN5dkpURm9zWTJZSEVBWkRWdllI?=
 =?utf-8?B?Q29ZbWlLWGVDa0haYU82N2xVaUdTbFNHSTV0ajdqRnBVYlQyNDByWXcrUFdO?=
 =?utf-8?B?TnFSZWNMZWFVTUN6MXVwTWg0R2pSbThXNGl0L0UvTUZBMVRYYU5UdUdYZkJH?=
 =?utf-8?B?bnp0VzZEdExRdHp5M1VzSkpjYU5PMlQxRmR5UW5DbXZDYVQvb3RRSWxXVWJv?=
 =?utf-8?B?c3hsUW42RUEwcHZOSVFBZGdkR3gxSmpJb1R3V2RDZGRHZXNBdGhPZHpXZVdW?=
 =?utf-8?B?NWwvd1FFNFFKNkFRVHNZOVNoM3kwK00wd0pkM0RTUzMycVJtWng5YVZPaEFZ?=
 =?utf-8?B?bnd1OTd1U0ZJZmhKQ256ZnQ3dnM5bTlSWm5LeHlEaXdWL2hvT2FUbStNZTZB?=
 =?utf-8?B?NFNiMFFHRUorVkpYVUd5UytjcnE0Rk92Vi96M1h5bW9yQ0d3M0Zjcng5TjN5?=
 =?utf-8?B?aldMMFVTNVpQK08yVXllNEgvK21Ybzh6WGZBc1F0SktoVU11WkYxbGthaktB?=
 =?utf-8?B?Tm84U1NZemQ2TmkvWFIvbFhuYS9mcFA1bmJwS1kyREk3dU9PeHU1akZxT01P?=
 =?utf-8?Q?fQYk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5af4931-9715-41bb-98d2-08db3f6876b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 17:23:30.3519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v4lw0I1jlSi6vGfllWOt3+Pw4y2EFUWiSbyoEPkOSac+rBRzpOvwlVxaTRHaO18L/qi4m4jcXjKzryfslYDorA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5388
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogU3Vu
ZGF5LCBBcHJpbCAxNiwgMjAyMyAxMToyMyBQTQ0KPiANCj4gT24gRnJpLCBBcHIgMTQsIDIwMjMg
YXQgMTE6NTHigK9BTSBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+IHdyb3RlOg0KPiA+
DQo+ID4NCj4gPg0KPiA+ID4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4N
Cj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAxMywgMjAyMyAxMTozOCBQTQ0KPiA+DQo+ID4g
PiA+ID4gMSkgc3BlYyBkb2Vzbid0IGVuZm9yY2UgdGhlIHNpemUgb2YgYSBzcGVjaWZpYyBzdHJ1
Y3R1cmUNCj4gPiA+ID4gU3BlYyB3aWxsIGJlIGV4dGVuZGVkIGluIGNvbWluZyB0aW1lLg0KPiA+
ID4NCj4gPiA+IEl0J3MgdG9vIGxhdGUgdG8gZG8gYW55IG5ldyByZXN0cmljdGlvbiB3aXRob3V0
IGludHJvZHVjaW5nIGEgZmxhZy4NCj4gPiBXZSBhcmUgcmVhbGx5IGRpdmVyZ2luZyBmcm9tIHRo
ZSB0b3BpYy4NCj4gPiBJIGRvbuKAmXQgdGhpbmsgaXQgaXMgbGF0ZS4gVGhlIHdvcmsgaW4gdGhp
cyBhcmVhIG9mIFBDSSBWRiBoYXMgbm90IGV2ZW4gYmVndW4gZnVsbHkuDQo+IA0KPiBJIG1lYW50
IGl0IG5lZWRzIGEgbmV3IGZlYXR1cmUgZmxhZy4NCj4gDQpPay4NCj4gPg0KPiA+ID4gTWFuZGF0
aW5nIHNpemUgbWF5IGVhc2lseSBlbmQgdXAgd2l0aCBhIGFyY2hpdGVjdGUgc3BlY2lmaWMgc29s
dXRpb24uDQo+ID4gPg0KPiA+IFVubGlrZWx5LiBPdGhlciBzdGFuZGFyZCBkZXZpY2UgdHlwZXMg
YXJlIGFsc28gZXhwYW5kaW5nIHRoaXMgd2F5Lg0KPiANCj4gSSB0aGluayB3ZSBhcmUgdGFsa2lu
ZyBhYm91dCBzb2Z0d2FyZSB0ZWNobm9sb2dpZXMgaW5zdGVhZCBvZiBkZXZpY2UgZGVzaWduDQo+
IGhlcmUuDQo+IA0KSXNuJ3QgdGhlIHNpemUgb2YgQkFSIGFuZCBpdHMgY2FwX2xlbiBleHBvc2Vk
IGJ5IHRoZSBkZXZpY2U/DQoNCj4gRm9yIGRldmljZXMgaXQgd29ya3MuQnV0IGZvciBoeXBlcnZp
c29yLCBpdCBuZWVkcyB0byBkZWFsIHdpdGggdGhlIHNpemUgdGhhdA0KPiBkb2Vzbid0IG1hdGNo
IGFyY2gncyBwYWdlIHNpemUuDQo+IA0KUENJIEJBUiBzaXplIG9mIHRoZSBWRiBjYW4gbGVhcm4g
dGhlIHN5c3RlbSBwYWdlIHNpemUgYmVpbmcgZGlmZmVyZW50IGZvciB4ODYgKDRLKSBhbmQgYXJt
ICg2NEspLg0KUENJIHRyYW5zcG9ydCBzZWVtcyB0byBzdXBwb3J0IGl0Lg0KDQpQQ0kgUEYgb24g
YmFyZS1tZXRhbCBoYXMgdG8gdW5kZXJzdGFuZCB0aGUgaGlnaGVzdCBwYWdlIHNpemUgYW55d2F5
IGlmIGZvciBzb21lIHJlYXNvbiBiYXJlLW1ldGFsIGhvc3Qgd2FudHMgdG8gbWFwIHRoaXMgUEYg
dG8gdGhlIFZNLg0KDQpBIGh5cGV2aXNvciBtZWRpYXRpbmcgYW5kIGVtdWxhdGluZyBuZWVkcyB0
byBsZWFybiB0aGUgc3lzdGVtIHBhZ2Ugc2l6ZSBhbnl3YXkuDQpJZiB1bmRlcmx5aW5nIGRldmlj
ZSBwYWdlIHNpemUgaXMgc21hbGxlciwgaHlwZXZpc29yIG1heSBlbmQgdXAgbWVkaWF0aW5nIGl0
Lg0KDQo+IEkgbWVhbnQgeW91IGNhbid0IGhhdmUgcmVjb21tZW5kYXRpb25zIGluIGZlYXR1cmVz
IGFuZCBjb25maWcuIA0KU3VyZS4gVGhlcmUgaXMgbm9uZS4NCg0KPiBXaGF0J3MgbW9yZSwNCj4g
YXNzdW1pbmcgeW91IGhhdmUgdHdvIGdlbmVyYXRpb25zIG9mIGRldmljZQ0KPiANCj4gZ2VuMTog
ZmVhdHVyZXMgeCx5DQo+IGdlbjI6IGZlYXR1cmVzIHgseSx6DQo+IA0KPiBZb3Ugd29uJ3QgYmUg
YWJsZSB0byBkbyBtaWdyYXRpb24gYmV0d2VlbiBnZW4xIGFuZCBnZW4yIHdpdGhvdXQgbWVkaWF0
aW9uLg0KR2VuMSBjYW4gZWFzaWx5IG1pZ3JhdGUgdG8gZ2VuMiwgYmVjYXVzZSBnZW4xIGhhcyBz
bWFsbGVyIHN1YnNldCB0aGFuIGdlbjIuDQpXaGVuIGdlbjIgZGV2aWNlIGlzIGNvbXBvc2VkLCBm
ZWF0dXJlIHogaXMgZGlzYWJsZWQuDQoNCkdlbjIgdG8gZ2VuMSBtaWdyYXRpb24gY2FuIGRvIHNv
ZnR3YXJlLWJhc2VkIG1pZ3JhdGlvbiBhbnl3YXkgb3IgdGhyb3VnaCBtZWRpYXRpb24uDQpCdXQg
YmVjYXVzZSBnZW4yIG1heSBuZWVkIHRvIG1pZ3JhdGUgdG8gZ2VuMSwgaGVuY2UgZ2VuMiB0byBn
ZW4yIG1pZ3JhdGlvbiBhbHNvIHNob3VsZCBiZSBkb25lIHRocm91Z2ggbWVkaWF0aW9uLCBkb2Vz
buKAmXQgbWFrZSBzZW5zZSB0byBtZS4NCg0KPiBTdWNoIHRlY2hub2xvZ2llcyBoYXZlIGJlZW4g
dXNlZCBieSBjcHUgZmVhdHVyZXMgZm9yIHllYXJzLg0KPiBJIGFtIG5vdCBzdXJlIHdoeSBpdCBi
ZWNhbWUgYSBwcm9ibGVtIGZvciB5b3UuDQo+IA0KPiA+IEFwYXJ0IGZyb20gaXQgc29tZSBvZiB0
aGUgUENJIGRldmljZSBsYXlvdXQgY29tcGF0IGNoZWNrcyB3aWxsIGJlIGNvdmVyZWQNCj4gdG9v
Lg0KPiA+DQo+ID4gPiBBbmQgd2hhdCB5b3UgcHJvcG9zZWQgaXMgdG8gYWxsb3cgdGhlIG1hbmFn
ZW1lbnQgdG8ga25vdyB0aGUgZXhhY3QNCj4gPiA+IGhhcmR3YXJlIGxheW91dCBpbiBvcmRlciB0
byBjaGVjayB0aGUgY29tcGF0aWJpbGl0eT8gQW5kIHRoZQ0KPiA+ID4gbWFuYWdlbWVudCBuZWVk
cyB0byBldm9sdmUgYXMgbmV3IHN0cnVjdHVyZXMgYXJlIGFkZGVkLg0KPiA+IE1vc3RseSBub3Qg
bWdtdCBzdGFjayBtYXkgbm90IG5lZWQgdG8gZXZvbHZlIGEgbG90Lg0KPiA+IEJlY2F1c2UgbW9z
dCBsYXlvdXRzIHNob3VsZCBiZSBncm93aW5nIHdpdGhpbiB0aGUgZGV2aWNlIGNvbnRleHQgYW5k
IG5vdCBhdA0KPiB0aGUgUENJIGNhcGFiaWxpdGllcyBldGMgYXJlYS4NCj4gPg0KPiA+IEFuZCBl
dmVuIGlmIGl0IGRvZXMsIGl0cyBmaW5lIGFzIGxhcmdlIHBhcnQgb2YgaXQgc3RhbmRhcmQgUENJ
IHNwZWMgZGVmaW5pdGlvbnMuDQo+IA0KPiBTbyBhcyBtZW50aW9uZWQgaW4gYW5vdGhlciB0aHJl
YWQsIHRoaXMgaXMgYSBQQ0kgc3BlY2lmaWMgc29sdXRpb246DQo+IA0KPiAxKSBmZWF0dXJlIGFu
ZCBjb25maWcgYXJlIGJhc2ljIHZpcnRpbyBmYWNpbGl0eQ0KPiAyKSBjYXBhYmlsaXR5IGlzIG5v
dCBidXQgc3BlY2lmaWMgdG8gUENJIHRyYW5zcG9ydA0KPiANClNvIGFueSBMTSBzb2x1dGlvbiB3
aWxsIGhhdmUgdHJhbnNwb3J0IHNwZWNpZmljIGNoZWNrcyBhbmQgdmlydGlvIGxldmVsIGNoZWNr
cy4NCg0KPiBDaGVja2luZyBQQ0kgY2FwYWJpbGl0eSBsYXlvdXQgaW4gdGhlIHZpcnRpbyBtYW5h
Z2VtZW50IGlzIGEgbGF5ZXIgdmlvbGF0aW9uDQo+IHdoaWNoIGNhbid0IHdvcmsgZm9yIGZ1dHVy
ZSB0cmFuc3BvcnQgbGlrZSBTSU9WIG9yIGFkbWlucS4NClZpcnRpbyBtYW5hZ2VtZW50IHRoYXQg
d2lsbCBoYXZlIHRyYW5zcG9ydCBsZXZlbCBjaGVja3MgaXMgbm90IGEgdmlvbGF0aW9uLg0KU0lP
ViB3aWxsIGRlZmluZSBpdHMgb3duIHRyYW5zcG9ydCBhbnl3YXkuIE5vdCB0byBtaXggd2l0aCBj
Y3cvbW1pbyBvciBwY2kuDQoNCj4gTWFuYWdlbWVudCBzaG91bGQgb25seSBzZWUgdmlydGlvIGRl
dmljZSBvdGhlcndpc2UgdGhlIHNvbHV0aW9uIGJlY29tZXMNCj4gdHJhbnNwb3J0IHNwZWNpZmlj
Lg0KPiANClNvbHV0aW9uIG5lZWRzIHRvIGNvdmVyIHRyYW5zcG9ydCBhcyB3ZWxsIGFzIHRyYW5z
cG9ydCBpcyBpbnRlZ3JhbCBwYXJ0IG9mIHRoZSB2aXJ0aW8gc3BlYy4NCkVhY2ggdHJhbnNwb3J0
IGxheWVyIHdpbGwgaW1wbGVtZW50IGZlYXR1cmUvY29uZmlnL2NhcCBpbiBpdHMgb3duIHdheS4N
Cg0KPiA+DQo+ID4gPiBUaGlzIGNvbXBsaWNhdGVzIHRoZSB3b3JrIG9mDQo+ID4gPiBtYW5hZ2Vt
ZW50J3MgZnVydGhlcmx5IHdoaWNoIEknbSBub3Qgc3VyZSBpdCBjYW4gd29yay4NCj4gPiA+DQo+
ID4gV2VsbCwgb25jZSB3ZSB3b3JrIHRvd2FyZHMgaXQsIGl0IGNhbiB3b3JrLiA6KQ0KPiA+DQo+
ID4gPiA+DQo+ID4gPiA+ID4gSHlwZXJ2aXNvciBuZWVkcyB0byBzdGFydCBmcm9tIGEgbWVkaWF0
aW9uIG1ldGhvZCBhbmQgZG8gQkFSDQo+ID4gPiA+ID4gYXNzaWdubWVudCBvbmx5IHdoZW4gcG9z
c2libGUuDQo+ID4gPiA+ID4NCj4gPiA+ID4gTm90IG5lY2Vzc2FyaWx5Lg0KPiA+ID4gPg0KPiA+
ID4gPiA+ID4gQ29uczoNCj4gPiA+ID4gPiA+IGEuIE1vcmUgQVEgY29tbWFuZHMgd29yayBpbiBz
dw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gTm90ZSB0aGF0IHRoaXMgbmVlZHMgdG8gYmUgZG9uZSBv
biB0b3Agb2YgdGhlIHRyYW5zcG9ydCB2aXJ0cXVldWUuDQo+ID4gPiA+ID4gQW5kIHdlIG5lZWQg
dG8gY2FyZWZ1bGx5IGRlc2lnbiB0aGUgY29tbWFuZCBzZXRzIHNpbmNlIHRoZXkNCj4gPiA+ID4g
PiBjb3VsZCBiZSBtdXR1YWxseSBleGNsdXNpdmUuDQo+ID4gPiA+ID4NCj4gPiA+ID4gTm90IHN1
cmUgd2hhdCBtb3JlIHRvIGV4cGVjdCBvdXQgb2YgdHJhbnNwb3J0IHZpcnRxdWV1ZSBjb21wYXJl
ZCB0byBBUS4NCj4gPiA+ID4gSSBkaWRu4oCZdCBmb2xsb3csIHdoaWNoIHBhcnQgY291bGQgYmUg
bXV0dWFsbHkgZXhjbHVzaXZlPw0KPiA+ID4NCj4gPiA+IFRyYW5zcG9ydCBWUSBhbGxvd3MgYSBt
b2Rlcm4gZGV2aWNlIHRvIGJlIHRyYW5zcG9ydGVkIHZpYSBhZG1pbnEuDQo+ID4gPg0KPiA+IE1h
eSBiZSBmb3IgZGV2aWNlcyBpdCBjYW4gd29yay4gSHlwZXJ2aXNvciBtZWRpYXRpb24gd2l0aCBD
QyBvbiBob3Jpem9uIGZvcg0KPiBuZXcgY2FwYWJpbGl0aWVzIGlzIGJlaW5nIHJlZHVjZWQuDQo+
ID4gU28gd2UgZG9u4oCZdCBzZWUgdHJhbnNwb3J0IHZxIG1heSBub3QgYmUgcGF0aCBmb3J3YXJk
Lg0KPiA+DQo+ID4gPiBBbmQgeW91IHdhbnQgdG8gYWRkIGNvbW1hbmRzIHRvIHRyYW5zcG9ydCBm
b3IgbGVnYWN5IGRldmljZXMuDQo+ID4gPg0KPiA+IFllcyBvbmx5IGxlZ2FjeSBlbXVsYXRpb24g
d2hvIGRvIG5vdCBjYXJlIGFib3V0IGh5cGVydmlzb3IgbWVkaWF0aW9uLg0KPiA+DQo+ID4gPiBD
YW4gYSBkcml2ZXIgdXNlIGJvdGggdGhlIG1vZGVybiB0cmFuc3BvcnQgY29tbWFuZHMgYXMgd2Vs
bCBhcyB0aGUNCj4gPiA+IGxlZ2FjeSB0cmFuc3BvcnQgY29tbWFuZHM/DQo+ID4gSGFyZCB0byBh
bnN3ZXIsIEkgbGlrZWx5IGRvIG5vdCB1bmRlcnN0YW5kIGFzIGRyaXZlciBuYW1lc3BhY2UgaXMg
dW5jbGVhci4NCj4gDQo+IFRoaW5ncyBtaWdodCBiZSBzaW1wbGlmaWVkIGlmIHdlIHVzZSBzZXBh
cmF0ZSBxdWV1ZXMgZm9yIGFkbWluLCB0cmFuc3BvcnQgYW5kDQo+IGxlZ2FjeS4NCj4gDQpEbyB5
b3UgbWVhbiBzYXkgd2UgaGF2ZSB0aHJlZSBBUXMsIEFRXzEsIEFRXzIsIGFuZCBBUV8zOw0KQVFf
MSBvZiB0aGUgUEYgdXNlZCBieSBhZG1pbiB3b3JrIGFzIFNJT1YgZGV2aWNlIGNyZWF0ZSwgU1JJ
T1YgTVNJWCBjb25maWd1cmF0aW9uLg0KQVFfMiBvZiB0aGUgUEYgdXNlZCBmb3IgdHJhbnNwb3J0
aW5nIGxlZ2FjeSBjb25maWcgYWNjZXNzIG9mIHRoZSBQQ0kgVkYNCkFRXzMgb2YgdGhlIFBGIGZv
ciBzb21lIHRyYW5zcG9ydCB3b3JrLg0KDQpJZiB5ZXMsIHNvdW5kcyBmaW5kIHRvIG1lLg0K

