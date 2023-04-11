Return-Path: <virtio-dev-return-12125-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986F6C77B70
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 13:57:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 64A912AC75
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 13:57:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 49A1098641A
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 13:57:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3B8BD98636D; Tue, 11 Apr 2023 13:57:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 286D598636E;
	Tue, 11 Apr 2023 13:57:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fb8r4E6rlr3FlEFG3c+MkP5DchbydaBd6LVldr5cpiCeM88/M55e93YtpNtOSalPimNdJp45RGOGnu4FAQHei2q8oGv/Ahj2QfY0o28ZxGegFDvhqbawouJDKFQcj7REPlrZn6xcYR60iKLMPyJMizUlrMbZCb7XZaeem199GqefJpfZD/0881GOe4/kY96xAKbQZc2NntwXh4zc1X31+djkSP9JBMMCD1fOFcX2wFv5lhLNKUTAGzwucymtqH1HJPFj3EWUvW2Tpotn3p2YJ0qOOzeUiuobVxgv5SAPDSXUcJjdICzBjK/pa02bCxqTBZafsv5UqwBS6QInEjmBtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/pCcQgK3kBnXq7DHR2+C5kj2HM7hDoJrZk0tADj5pI=;
 b=oMHOHpprYMeGjZgSerFkqkjZDHngCb2TGvpC3iNDo/xc63uHW79RgFifsky13wUt225SCoz3C+5XbZoC7U0p2xNr20WZ8YHXzKnd+h6/w3blBd/HI+fnsp3lq1q5ziTtaNFnSJ0AAfJiM8pGYWCMAb74kcbcgpN0+OKwxGqyMqkDGI+h28pvItmA3egptw8yhh7Lt3lkm2vVAR+10M/xTB5ieL69MW2/3dOW18sz4anh7p2UH7tCzaSssdpLJF0Uqrlwmgtrepn5ZL28lBnHTu6fvqWZZV735iXtDeavaDFM4cczRydqVtl+pN9KXpqeGFqtmXzqncEe6Lou988HnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>, Yan Vugenfirer <yan@daynix.com>
Thread-Topic: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers
Thread-Index:
 AQHZY1tLAUtRpuZtUUOucQPGJlFfkK8flpUAgAQ7nwCAAE6hgIAAAXwAgAAFegCAAAt0AIAALl6AgAEOIwCAAFEgAIAAIPWAgABQKlA=
Date: Tue, 11 Apr 2023 13:57:11 +0000
Message-ID:
 <PH0PR12MB54814C174F61403E8530EA54DC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-10-parav@nvidia.com>
 <20230407043841-mutt-send-email-mst@kernel.org>
 <CACGkMEtkOdwixxaRz2Pv9xP75vb13ncboX5XRs8NqFCUsS16aQ@mail.gmail.com>
 <20230410020906-mutt-send-email-mst@kernel.org>
 <CACGkMEtiROwuB+ECJqd13qdpMJSTMoDOzi1u_i85==42C0XSXw@mail.gmail.com>
 <20230410023715-mutt-send-email-mst@kernel.org>
 <CACGkMEs+E_OarQxP3NmLk3iSi7U0WgAn-m3b4eX7ULu1+v=sOw@mail.gmail.com>
 <20230410060417-mutt-send-email-mst@kernel.org>
 <CACGkMEuc47PdmQdC67Nz4AvX_+jy+XBgCkwZ1BHmM8VGb9gywA@mail.gmail.com>
 <20230411030056-mutt-send-email-mst@kernel.org>
 <CACGkMEt2QAfhCgpYjSRNzf3n4W_HJLrMfE9JHzocR_gPH_Zrtg@mail.gmail.com>
In-Reply-To:
 <CACGkMEt2QAfhCgpYjSRNzf3n4W_HJLrMfE9JHzocR_gPH_Zrtg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB6957:EE_
x-ms-office365-filtering-correlation-id: 26c6c1e3-515c-4f94-6f46-08db3a94a598
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yRO2BooOy4kp/a+XV/ZvHiBu5VqHn0MCRkxDBOgFY3ixiMpaN5gi0t3VHOB6OgY+XXYa8kjHp4n4K64b18cyVOEkD1YhyyIdmcsFQt1gr2o57L54KVkTBVCJCj9vO4kuKlFjWY4mT6tyUuyg6wojM8PhZDFU3evjwshqUf31BmwYp+ot9JS+TWLtp2fp4ZcESGrUyKBxboK+D4+f9R0p0ik0fn3ndVeLtBmMUV3db6k5GiepWs5UG3AJvAzKP7LlsZCUsYh69xsUF9Lza1pkoI/J1Uk3k0beU/T9NzKxbhG7MSEKO0Ao4oWdfyq7++KFR7Y2ip7Djw6YDR292gAa2YR5CLzOUwhq5L6ZdOUQUGxI4cru22ipsv0xRY4NlpQVNDzj1qt0RIlJfgeephNUXjClE9n9f68YspSrmS96egXYYkCabP9px9ZmdPaIpuvfztdEPBQ+NMF/bWRCWO5kN8K3poiUMycO9S7WDn4hMxBo22cxFXzCk7j570sK9jXPVp1pJcqOkg02Om9pepMhtEm99xCBuVkxdqPg9pnvNrAfMQBHa9WCMboYGX1mx3c+9VXbfEPSIIxWyxrfUMJYHfIwQzsi9b0+naWpyuLQKOaJiB1ViBl6UybpPZUv2cQA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199021)(64756008)(4326008)(110136005)(54906003)(66476007)(66556008)(66446008)(76116006)(316002)(66946007)(71200400001)(478600001)(5660300002)(7696005)(55016003)(8936002)(41300700001)(52536014)(8676002)(86362001)(2906002)(38070700005)(122000001)(33656002)(38100700002)(6506007)(83380400001)(186003)(9686003)(66899021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1dra1o3ZUZ0czhqY0o3OWQ0L1crTXJKVlRRTWlRN0pXQlhmQTBvN0hDWVpo?=
 =?utf-8?B?TDhLRDRRNUpqZGZqeCtmaVFoUktIcE1iNE90YzVKSk1QdzRCSW95SklGajc5?=
 =?utf-8?B?TzY5YUxCL1ZLb21OaEZ1OGxJVU9aUzZjVkQxWjI3Z0thbjkyZGxBdTVWNVZv?=
 =?utf-8?B?cEdHWWgvWWFYSGZaK0RwZzYwTUh2ZWpvLzZFWTRnc1ZEZktrV1IvRE5RZU9E?=
 =?utf-8?B?K2p4Mlg5MklFZFR6RHR1R2IrbURuWDNmeWt5NTlWYmRTQ0FpV29vQk0vVUlx?=
 =?utf-8?B?bU5DNVpNSmI0cVlxRmZuYlNBZkpzYTJXSkIxMG80ZVFuNWVET1FTT1R5K0Qz?=
 =?utf-8?B?emVVS29yRGRpM0xNQ2ZVWVZxK3VLSm44SER3N3NIT01ZQ3FxZEN3UWNtTFBy?=
 =?utf-8?B?UUNsRkNESFRkNkk2OEtzUHNxWUp1NnJtRkxsdlpsZGV4UUpaL0hEc1U5VWwx?=
 =?utf-8?B?Ylh0L0dHNTFjcmF4dlhIZGJVbmFZSzRvelNNenFmZVEvUGRzT1JVWjBZMHJP?=
 =?utf-8?B?L0IvVkczWTBjWVZpcmtxSkdtNllzMFJkQ3NTZU4xWmJabzgxOUlCSmFSbk4v?=
 =?utf-8?B?T09qdWFub2REUHUyVHhwQVZDU0IxSWVRNUw1NC9IZ0FEVXErbm5iejZMdWM4?=
 =?utf-8?B?bTRpV3pkWmdDY0dacVNtQ0cxaGZlUnpQeTZCWGl3QmVZaXZINy9HSm5WZ2tF?=
 =?utf-8?B?MktHNzEya1daMlR2d1pDVVlrVDVYTzN6YzJTVnh1elBOYVYyL1hodldtcGQ2?=
 =?utf-8?B?V0tnTlBpSE5VTDk1RjM5enIzNzJ2WHFYRWRLMkFNRlUvQXlzdEhHV0dZeFhV?=
 =?utf-8?B?amFKNUFVRU0xSUhDUGtURFN6UURrUjg1dG5Mb1MrMVVCODZ0cEZYSHhJTkpi?=
 =?utf-8?B?WnUxWjFheGpjODVYcW16ZzNPQWRzUGdHNDNyb3lRbWxGR2NNMyt4WWVpdjdj?=
 =?utf-8?B?ZE9PcFFDc29HR2lLZ2dqMXREUjFCdXJmUjZGeUJ3a1NsTHZsa0tDbkdpOXph?=
 =?utf-8?B?Qk42OE9oY0FWTXMzY05pbmp4M1hYbEpYcndaWG43RWtsM3dkaHV2VFJqYVRm?=
 =?utf-8?B?bDU0akVSRDdYMGdoZkJ4NE9INlNvVmhZTGZCcmlTYXN6MUJwUWNLU3o0NDcw?=
 =?utf-8?B?YnFSYnZvd2NNcUNnRW5MbS9uT3NzWXhXdEIvT0dXUVVEcmQzZTNBemJIVGlC?=
 =?utf-8?B?MHBYc2Q4em9ZSXI2RWpmK0QxSWtWY3R1cGFlZlVndUNFejhMNzM1bml2NDVu?=
 =?utf-8?B?YzdtejNIU2ZhSFpMamdhWkFBaDRyMkU3clpEYmpNWlovM0R2NEFEb1pMQ2gv?=
 =?utf-8?B?b1h6RXlZZGpQZDIrazJOM2p3K2RBTkFPYVNBbGo0T2RLd2kvTEFOc0tEaDVq?=
 =?utf-8?B?eTEwQ055eDY0amtBQjNSMVliNDc5NTB0UnZDQTM3VEp1eExyOUpkdDhlN3dQ?=
 =?utf-8?B?dS9ObFJpUjl1bWVFbVFGSzFNbDBENm94QVRZR2pBOHVYNUVjWlpRZGx6bm1G?=
 =?utf-8?B?K09ZbzVaQjdCclF2MG9HNU03SzFXY29sbUhHdG9QWDFuVGdkRmUzU21QWHR2?=
 =?utf-8?B?Y1JqMVA5OEJHNlF6OG9JeFBkeVZ1UnpRT2NXNWtPZ3VPZlJ3Nkl2NVNZL01F?=
 =?utf-8?B?S2w5VytMOWxsK041NEViYnRIRElVVlh1YlgxTDNFYThmQTRTZlQyOXpHSGZU?=
 =?utf-8?B?Y3NxZXBMSVBTdE9oWDNvSWdkQ2IxRERnTnR0TWY1NE1RUzVrajUvV2t3Vzh2?=
 =?utf-8?B?ajVGZXNUcnJWZUdIenQzZGZsNVhGS0I1M2FnTVgvN2lwVzFQdXlkVmJwWXRG?=
 =?utf-8?B?UEdLdmRJNE9mNEFXSHhyU0wrcGczOVFVZEd2NlM4S2o0eHAxQ2I2b2xVUThx?=
 =?utf-8?B?Q01wSVRzcEE4RldRQUNwQlRDTWZRdlQ0SnZYeUI0c1FrN1FYRW1rZ1Vrdzkx?=
 =?utf-8?B?UnBSckVUVDVsLzFGUk11S2owWFBydmx4Q2FTdTNQbHBsOFhjc0RPdTVKd1ho?=
 =?utf-8?B?NVZOazZkQjR2RU9Ccnpld2doSHhCMlZ6WWhFaXgxTWxXUFJNRTA1YmVPdHpv?=
 =?utf-8?B?Rk1OeDkwbkM4TlpMcHR1VkhldnQ2cHdHclM4aWt6a0hZOFFTcWltbU1mUng3?=
 =?utf-8?B?ZzA5eTRwS1U1aWJjOVhEQnFHdURuczNLMnJhNm03MDZhN2lyNjJleXQzcFNG?=
 =?utf-8?Q?AuDG205Owg0m2smmf82zUsk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c6c1e3-515c-4f94-6f46-08db3a94a598
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 13:57:11.0693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +mx2bAN5TdkUyH00rAsN/0osDXvUsPKN83B+xvqcNrtvA8bqZgw82st8hli6jDdZU9KOglrspuOhqs/6sY5VkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6957
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIEFwcmlsIDExLCAyMDIzIDU6MDIgQU0NCg0KPiA+IFRoZSBwb2ludCBvZiB0aGUgY2FwYWJp
bGl0eSBpcyB0byBhbGxvdyB1c2luZyBtb2Rlcm4gZGV2aWNlIElEIHNvIHN1Y2gNCj4gPiBndWVz
dHMgd2lsbCBub3QgZXZlbiB0cnkgdG8gYmluZC4NCj4gDQo+IEl0IG1lYW5zIGEgbWVkaWF0aW9u
IGxheWVyIGlzIHJlcXVpcmVkIHRvIHVzZS4gVGhlbiBpdCdzIG5vdCBhbiBpc3N1ZSBmb3IgdGhp
cw0KPiBzaW1wbGUgcmVsYXhpbmcgYW55IG1vcmU/DQo+IA0KSXQgaXMgZGVzaXJlZCB0byBmb3Ig
dGhlIGJlc3QgcGVyZm9ybWFuY2UgYmVjYXVzZSB0aGUgbm90aWZpY2F0aW9uIDJCIGlzIHNhbmR3
aXRjaGVkIGJ5IGxlZ2FjeSBpbiBtaWRkbGUgb2YgdGhlIGNvbmZpZ3VyYXRpb24gcmVnaXN0ZXJz
Lg0KU28gbGlrZSBkZXNjcmliZWQgaW4gcGF0Y2gtMTAsIGEgbWVkaWF0aW9uIGxheWVyIHdpbGwg
YmUgYWJsZSB0byB1c2UgZGVkaWNhdGVkIG5vdGlmaWNhdGlvbiByZWdpb24uDQoNClNlY29uZGx5
LCBQQ0kgaGFzIG9ubHkgZWZmZWN0aXZlbHkgMyBCQVJzLg0KSXQgaXMgYmV0dGVyIHRvIHJldXNl
IG9uZSBvZiB0aGUgZXhpc3RpbmcgQkFSIHdoZW4gcG9zc2libGUgZm9yIHRoZSBkZXZpY2UgZGVw
ZW5kaW5nIG9uIHRoZSBmZWF0dXJlcyBpdCBvZmZlcmVkLg0KU28gYmV0dGVyIG5vdCB0byBoYXJk
IGNvZGUgdG8gQkFSMCBhbHdheXMuDQoNCj4gQW4gYWR2YW50YWdlIG9mIHN1Y2ggcmVsYXhpbmcg
aXMgdGhhdCwgZm9yIHRoZSBsZWdhY3kgZHJpdmVycyBsaWtlIGFuIGFuY2llbnQgTGludXgNCj4g
dmVyc2lvbiB0aGF0IGNhbiBhbHJlYWR5IGRvIE1NSU8gYWNjZXNzIHRvIGxlZ2FjeSBCQVIgaXQg
Y2FuIHdvcmsgd2l0aG91dCBhbnkNCj4gbWVkaWF0aW9uLg0KTWF5IGJlLCBzdWNoIE1NSU8gQkFS
IG1hcHBpbmcgdG8gdXNlciBzcGFjZSB3aWxsIG5lZWQgcGFnZSBhbGlnbmVkIEJBUiBpbnN0ZWFk
IG9mIDMyQiBvciA2NEINCihZb3UgYXNrZWQgYWJvdXQgNEsgaW4gb3RoZXIgdGhyZWFkKS4NCkl0
IGlzIHVubGlrZWx5IHBlcmZvcm1hbnQgZHVlIHRvIGludGVybWl4aW5nIG9mIG5vdGlmaWNhdGlv
biBhbmQgY29uZmlnIHJlZ2lzdGVycy4NCg0KU28gbGV0dGluZyBpdCBkcml2ZW4gYnkgbm90aWZp
Y2F0aW9uIHJlZ2lvbiBpcyBiZXR0ZXIsIG1heSBiZSBzb21lIGRldmljZSBjYW4gbWFwIHRvIHRo
ZSBzYW1lIG5vdGlmaWNhdGlvbiByZWdpc3RlciBpbiBtaWRkbGUgb2YgdGhlIGNvbmZpZyBhcmVh
Lg0K

