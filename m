Return-Path: <virtio-dev-return-13044-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABB7EB64DA
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 16:54:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5AB2C171D08
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 16:54:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 515B29865EC
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 16:54:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 46D439865D0; Thu, 22 Jun 2023 16:54:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 350A49865D1;
	Thu, 22 Jun 2023 16:54:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUBhIVCYTw0V6A5sK/Nq8Ps4teWObg4GlM1KMGRFfXSJQd96wxCX869TlsbwYfR0AmlgAiUFwZAcM8rtghTaO07CS+lldMcqnoG6hS441G0FFT5Pq6LcOnjPR7HM6kuXarqxs1S/YD1okWF0VkVCOjf7cMEp+IFFPXuBEVWyRm26y21ibVlnpFdNQUBOb+RxEeJAx4tf96suP9pcYbD99MtJoBPglHR867kjQAjGwrwvaWRPMkVtM+O4t43Ux9jub+gd48DqKkIwRcuirWHA+ZO66GFBtueHGoQ68R0ntu7+64tb7jmPQ1r5klKuaXCpUUaI1y1adMLk4KVAxWbdgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sobNj0UO+q+aZzNxW5QW8IXcp//QWdUV+rJRHN5rgXU=;
 b=AJ36L761giT6cEC95efJN1hmtk7NKMLXL9Ca3ViK9Vj/jlgEU319v8H5W/QDK4DNB8TbUGE55WzHenRrtf9WuNl6GrU4+oKK1j5Essv+YloPwLXuSSreF6KcY1vXCe4XU1SzfMSL7WDi5ecziTV8+XShKWFaN2lN/iVirSCZbAnyD/FP7v97/ZffmsHhDfQNh5bSvpjh1KFaqEr7Bf88IwErGBq2vAUdn1kTaKHp6YLvchNpwQnaAteduAOYIwMCAbie3c7kvs45xcE8WHakmg4LkjZec1C3xCPGoMGtCZuw4VgdI/PV60h7h+XGfObLuE4O8Uf0ipZK8PNPVufthg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>
Thread-Topic: [virtio-comment] Re: [PATCH v18] virtio-net: support inner
 header hash
Thread-Index:
 AQHZpEdpSlZ4I0eUeUmZIFkjtAkw3q+VZGYAgAASyQCAAC5zgIAAADyAgAAMJYCAAAHeEIAABAeAgAAB1cCAAKHPAIAAY0PggAAXcACAAAvqkIAAJ4CAgAAA4IA=
Date: Thu, 22 Jun 2023 16:54:48 +0000
Message-ID:
 <PH0PR12MB548100743287D401B8ED78CFDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230621152559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481141E18AAF1BF214A0E29DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621161157-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C99B8504F02D39B3A6F0DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621163116-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4EA5D0614E1289DFC77DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622021932-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <82e83a90-6491-c20b-d96d-f9e0d15c2641@linux.alibaba.com>
 <PH0PR12MB5481A5055A5F58045437391CDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622123203-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230622123203-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM6PR12MB4267:EE_
x-ms-office365-filtering-correlation-id: 1f370b87-160b-4b7b-bf29-08db734163d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7YSBO+Mgph9SMGp3utzbaB677yUvxVQ1PinRasvaMkJdCzPdvqEg8OtFTY5vSM9YQ9TBi7mh+NqwKskiXHmSE9lQfImnL/rdpTS6qAiVmvq5jsH2nLwINY8FiHe/s6DteHv4EXJqr4/lDTdefWPJZt8B+y+9EFD8uULCiLqrwJuFMwD/Orvn2WvkWmKC9gsygQxpXVxvyvy2QHBPX8hcDuvZE2kqc4uHhYBW3ueu6mj+Aswdd75pwaEgcYkHEOnpujsfLrXcIsPMI58C5WIfQ8N4R7LpNQxa/QbM3+6lXY3KGKuMm5QnBWWCWvy8cJ9A5LwADsdrhmuq9NcHJCp0PGyJf5KwCoUV1CBVR59R/5LT0266RDFvnMaHFIYSfIQ7hGJTxJKLpgHMBUxKadRsQt0Dr9fkBB2Tb2mhF6lgwvKXrUKA8hnlOrakbhJw7RYOYZW3D8WrYze5r9Mh9roUeuYWv3RfrbZ6M4IjUtDt9QlHm1On7uWdmDqk1lOnQfilSPkY6BNbfLyANFLxgCvBew6OGnqxG4oITWBJulQm7cXvzAsRqT6nyLA5Y+VoaSlRpMYCWyGM9OSz1VRKm+VAak6L/FQo2avgywrSdjMlU/x/foqrElh/E7OyblHTNgTM
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199021)(6916009)(4326008)(66556008)(66476007)(66446008)(64756008)(54906003)(316002)(66946007)(76116006)(122000001)(71200400001)(83380400001)(6506007)(52536014)(86362001)(2906002)(7696005)(5660300002)(41300700001)(9686003)(26005)(55016003)(186003)(8936002)(33656002)(8676002)(478600001)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eHFaZE11clE3SG8wVVk4RW80ODR4UDdMcUUwSE1oZ2k0YTJFUEQza212aXBY?=
 =?utf-8?B?bW5pcnUvNnBuNjc4S3VGWkZQalhveGExdWJlZkVGR2ZYaDNyWFZwVGxoY0cw?=
 =?utf-8?B?TmNCamxad1NRT2pTSEdaMmpnWjFJeEpSYXQwWFMvdmQ3endsWWo0OW5sVUNp?=
 =?utf-8?B?SlZYUG96QStjMUhoN2I1aTM0M05kS01KcGVLTGpvM2s5NzJWOWNhWU91U1Zw?=
 =?utf-8?B?dHd4bW9LWStjNHRsaDNEK1Z3RktPZWVqUDc3eTJqTXowZXpxV3QyckZmb1RB?=
 =?utf-8?B?aUh0SGMxMVN3UCtzS245ZDI5YUs4R2Q3WG5NYW9rNUJGZ1ZOV3h2QzFKN3ZZ?=
 =?utf-8?B?eGJnN2dmMitmd2lieWFLNXArcFZQRzZSbUJWOWVTODdUNmI2aGh2R3cvOGJW?=
 =?utf-8?B?R3RvcE51ZWtpQ3FBd1BjTGRqZVdHUGJObnAxMlZDamtBS1Y5MzRSMGZqd0Fr?=
 =?utf-8?B?Zm1qRFkvM084TmQydkx6SVJ1THNFNkRlMGVRWHY1ZThVa3NyT3Vyc2FvN2RG?=
 =?utf-8?B?VUVQN2VrcGw5SXFEZDErUEh4emh1VU4xdHRXc0grM3hHNEw2aVg4d3BCUkt2?=
 =?utf-8?B?VDByMVBKZU1BenVFSVZsSk9wcTVDNXVVaFNlUDE3R3JhbFhrcXl2NmRvKzJs?=
 =?utf-8?B?bnJaQnlSOHFHWGRFMlgzdUNWNTY0dnJTM1BEMXdDaHd1cVNxRThBR2FQWW5h?=
 =?utf-8?B?R2I5UHh0bFV5QzNiQm9ZT0pHYUthUDMvUmpiR3ZzTDRrQ2I5UHg1Z1BmejFO?=
 =?utf-8?B?cmtBMnFucGdoTVZHalJVamFMMnJvWnFtd256MzJuUjZVczJKT3NhUWh4ais1?=
 =?utf-8?B?YXA5V0FYVWJhNncxMkpzM2VTbDZsVDBhWlNMdGdwR0QrN1NuVWF3aXhWbDJJ?=
 =?utf-8?B?L3NmMHRaZEhxVy9pM2FnWncyTUNaNk4yZUtpUEdJM2dnYzdUck8wTUlIcFNM?=
 =?utf-8?B?eVNpWEI3WnF2dHBiR3A4R25Zb20yUndZbTJPaGtNNkYvck1UN3pLeWxRNGdr?=
 =?utf-8?B?cUxzUkNnUmptajZnYnM5ZFpBdERqVU5BbUFydUF1UkJNdDhzUGFKMFZzZVJx?=
 =?utf-8?B?MFltdGlENVpENXIzS0Z0dXNSQU03ZkcvMEtPL3RRV0xRdmpWeHoxeUUwTXBI?=
 =?utf-8?B?dGM5bTkzRW5zMHFZK0tCeUlQRzBjTmVUSHVhUjJCbnlFQ1k1MjFqVGY3REJU?=
 =?utf-8?B?Nnd3M2ZScHBsbHgrOFJVbWR3b1pYVGR2Nk9pWHZ4MkswaCs1Z2lsUUtTOXVl?=
 =?utf-8?B?ZGt3UVhRUlBrajFJUXdyRGZ6Y01mNTFUVER0V1lkTkxsakpocjdmem03SlRk?=
 =?utf-8?B?VmM0aTB6aWNScUNwRmRDWTRlaWpLOHlIekpGejl6L0Y3QUNXNm5jSWh3L2pR?=
 =?utf-8?B?Tk43Mm1SSGNSTTNNN3hrWGx4QzFDc2E1bHRiQisvU3VLL25SNEtIUUZYc0hk?=
 =?utf-8?B?ZjhOZFg0aDNadVFkUG5GMlJzeU52UjZXVG9oZFpBNXVTb2V6TW15NHhOc0FK?=
 =?utf-8?B?ZnJ0RCtkUHBMRWdOT3NTbGN1cjJHRXI2MVV2cXF0QlJKSGs3VFZHNHdXYXhJ?=
 =?utf-8?B?eHpLY3E5SWtOd1R0RnduZVhiSmxXRnJIdGZIbDNzUEo0MkVtK1FhbExyejlD?=
 =?utf-8?B?U1hQY1did0JJd2czem9VRHQrb0tXcTZ0cTQvdDJaTW9iczNRMU1WbnVxczJB?=
 =?utf-8?B?T1MrWlQ5TDRmR0VJZUhVU3podGRTTzlZVnRNSk5ZMTZ6TFkxTE9GRGlIVEZq?=
 =?utf-8?B?U0FOazR1THptZ014NWxhRk9vVWhNdVM1RWhhaldxVzM4VHFMcmNwbHdiQ1Nk?=
 =?utf-8?B?WVFWZ2I5M0Fsb3FqMWxzYUpvbkhKSURiNGc5TWFBQmpBYXFJVmluRDR1WTND?=
 =?utf-8?B?Y1cybUsyOWsyM0RVRVUvSnN1QVQ0R1M1bnErUkp4NzJQZnhkTURWeXJUY0xV?=
 =?utf-8?B?endiT0ZKU1EwZ3A5VDM1OVBiSW5rRWl5bzRPczM5V1NLTTZuVmNXT0dIby9G?=
 =?utf-8?B?OStrNldhUDRlUTZLRDZJelQxa0xRQ2lwQ25yWVRwaWRaVDJqWjJJYlM1QVJM?=
 =?utf-8?B?L25wRTlFOEdlc09MV2VtMGxRK1pmNmIvK3FGZVVkb3gwSURQRmJaWFFPQThw?=
 =?utf-8?Q?9KP4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f370b87-160b-4b7b-bf29-08db734163d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 16:54:48.7805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RPDSZz4RrXBgzwiU5jH4JujVWFsSqyAbDqgeSZn/TmDB4GR1yHdPEYB3A1mHyj3QW1Bidqjifxsih+CMZOUoqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v18] virtio-net: support inner header
 hash

DQoNCj4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDog
VGh1cnNkYXksIEp1bmUgMjIsIDIwMjMgMTI6NDcgUE0NCg0KPiANCj4gVGhlIGhhcmR3YXJlIGZv
b3RwcmludCBvZiBrZWVwaW5nIHRoaXMgaW4gbWVtb3J5IGlzIGFsc28gZmFpcmx5IHNtYWxsIDop
IEkgY2FyZQ0KPiBhYm91dCBhIG1lc3N5IGludGVyZmFjZSBiZWNhdXNlIHRoaXMgbWVzcyBidWls
ZHMgdXAgb3ZlciB0aW1lLg0KPg0KSXQgaXMgcmVhbGx5IGEgc2ltcGxlIEdFVCBjb21tYW5kLg0K
SXQgaXMgYWN0dWFsbHkgbWVzc3kgZm9yIHRoZSBkZXZpY2UgdG8gaW1wbGVtZW50IGZ1bmN0aW9u
YWxpdHkgaW4gdHdvIHBsYWNlcyBpbiBjZmcgc3BhY2UgYW5kIGN2cS4NCiANCj4gQW5kIEkgYW0g
d29ycmllZCBhYm91dCBjYXBhYmlsaXRpZXMgcmVhbGx5LiBNeSBiYWQgdGhhdCBJIG1pc3NlZCB0
aGlzIGNoYW5nZSBpbg0KPiB2MTMuIEkgb25seSBjYW4gc2F5IGluIG15IGRlZmVuY2UgdGhhdCBJ
IGFscmVhZHkgaGFkIHRvIHJld3JpdGUgaHVnZSBjaHVua3Mgb2YNCj4gdGhpcyBwcm9wb3NhbCB0
byBtYWtlIGl0IHJlYWRhYmxlIHNvIG9uZSBjYW4ndCBzYXkgSSdtIG9ubHkgZGVsYXlpbmcgdGhp
bmdzLCBJIGFsc28NCj4gbWFkZSBhbiBlZmZvcnQgdG8gaGVscCB0aGlzIHByb2dyZXNzIGZhc3Rl
ciA6KQ0KPiANCj4gSSBmZWVsIHdlIG5lZWQgYSBzaW5nbGUgcGxhY2Ugd2hlcmUgZGV2aWNlIGNh
cGFiaWxpdGllcyBjYW4gbGl2ZS4gU28gZmFyIHRoZXkgd2VyZQ0KPiBpbiBjb25maWcgc3BhY2Uu
ICBJdCdzIGNvbnNpc3RlbnQsIHllcyBJIGdldCB0aGlzIGhhcyBoYXJkd2FyZSBjb3N0cyAqaWYq
IHRoZXJlJ3MgYQ0KPiBodWdlIG51bWJlciBvZiBWRnMgYW5kICppZiogdGhlcmUncyBhIHdheSB0
byBwcm92aXNpb24gZWFjaCBWRiB3aXRoIGEgZGlmZmVyZW50DQo+IGNvbmZpZ3VyYXRpb24uICAN
CkFsbCB0aGUgaWZzIGFyZSB2YWxpZCB0b2RheS4NCg0KPiBBbmQgeWVzIHF1ZXJ5aW5nIFZGcyBv
dmVyIE1NSU8gaXMga2luZCBvZiB1Z2x5LiBCdXQgaXQgZG9lcyBhdA0KPiBsZWFzdCB3b3JrLCBh
bmQgd29ya3MgZmluZSB3aGlsZSBWRiBpcyBhc3NpZ25lZC4gIFNvIHdlIGNhbiBidWlsZCBtaWdy
YXRpb24NCj4gYXJvdW5kIHRoYXQgKnRvZGF5Ki4NCj4NCk90aGVyIHdheSB0byBzYXkgbWlncmF0
aW9uIGNhbiBiZSBza2lwcGVkIGZvciB0aGlzIGZlYXR1cmUgYml0LCBhbmQgaXQgc3RpbGwgd29y
a3MgZm9yIHJlc3QuDQogDQo+IEJ1dCBxdWVyeWluZyBvdmVyIGN2cSB3aGlsZSBWRiBpcyBhc3Np
Z25lZCBjbGVhcmx5ICpkb2Vzbid0KiB3b3JrLg0KPiANClRoYXQgaXMgbm90IHRoZSBpZGVhIGF0
IGFsbC4NClF1ZXJ5aW5nIFZGIGNhcGFiaWxpdGllcyBpcyB0aGUgcm9sZSBvZiB0aGUgYWRtaW4g
Y29tbWFuZCBmb3Igd2hpY2ggd2UgYnVpbHQgaXQuDQoNCj4gU28gd2hhdCBpcyB0aGUgc29sdXRp
b24gcHJvcG9zZWQgZm9yIHRoaXM/DQo+IA0KMS4gUXVlcnkgbWVtYmVyIGRldmljZSBjYXBhYmls
aXRpZXMgdmlhIGFkbWluIGNvbW1hbmQNCg0KPiBZZXMgdGhlIGN1cnJlbnQgbWlncmF0aW9uIGlz
IGJyb2tlbiBpbiBtYW55IHdheXMgYnV0IHRoYXQncyB3aGF0IHdlIGhhdmUuIExldCdzDQo+IGJ1
aWxkIHNvbWV0aGluZyBiZXR0ZXIgc3VyZSBidXQgdGhhdCBpcyBub3QgMS4zIG1hdGVyaWFsLg0K
DQpUcnVlLCBpdCBpcyBub3QgMS4zIG1hdGVyaWFsLCBoZW5jZSB0aGUgcHJvcG9zYWwgd2FzIHRv
IGhhdmUgdGhlIEdFVCBjb21tYW5kLg0KT25jZS9pZiB3ZSByZWFjaCBhZ3JlZW1lbnQgdGhhdCBu
byBuZXcgZmllbGRzIHRvIGJlIGFkZGVkIHRvIGNvbmZpZyBzcGFjZSBzdGFydGluZyAxLjQgYW5k
IHNob3VsZCBiZSBxdWVyaWVkIHVzaW5nIG5vbiBpbnRlcmNlcHRlZCBjZmd2cSwgaXQgbWFrZXMg
c2Vuc2UgdG8gbGV0IHRoaXMgZ28gaW4gY2ZnIHNwYWNlLg0KRWxzZSBHRVQgY29tbWFuZCBzZWVt
cyB0aGUgZWxlZ2FudCBhbmQgcmlnaHQgYXBwcm9hY2guDQo=

