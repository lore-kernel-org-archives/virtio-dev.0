Return-Path: <virtio-dev-return-13946-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33B1E81810
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 02:24:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5810B120D73
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 02:24:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4B02B986420
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 02:24:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 38CC7986378; Tue, 26 Sep 2023 02:24:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 21B8F98639D;
	Tue, 26 Sep 2023 02:23:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCeq4WvFa3bG2HKLfDMt2BsMplWJvmGbc16LgElhWnc1i+z9y8SkdPxSt2Jz1jhJrNwhccNHBFl3DmOQLWZGMoJRa7bRM6mVIF29PSXv/onJmfOt+nKGJ7CeyDgtUhWQiKPEwihxmytw+AaILaT4fcGt0L57i9ah7JqTKNhe5fUl2xCmiR14sciqu4MBx5ClMgPF+JoquvkjPtzWLJLNaorm2no1E6bPguPE1PyJCzty3mlmJqYnDWnX70LhJ+GbEpLzdZHA7ardhYfVqzMln7yKnm62fF5UWuArXqVSaXXDM/v+BQy3R6qDxZ5DtXBD8NC9bJSBKb3+7nWvk4voog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KCGCEsxYUr4fzHQF4NFX703WMuIWgXePajPBng6rgs=;
 b=KTFHUVEJsi9sCudIpVARNu5HWc+T6nyQPY6wgWIDu6hLxCBK1rn52syhN9E58ub7rhzpxIDaPOUVinO/CLs77vvU6tlXhCbIPxNSqHIDIbkL+m4t8xNa648Lvgm6O1TEVB7iZvGvHRHDn8VUQ5Ramu1BDacv41lS77lpNe30ppZj1D4bNpatZ/EC4B13eVtpaIeNP4cTmBuJ2cApdvBh0Frczs7ubPWHE407apH0Fdh3GzDaYB8QqYf0KsY7bZ5N/ugvwYvpVQf0prBw7y2HHJS9dv31MEBVHTZiDt+i8P26bjctv9FS6yaqL6Txd3ajgfBMLnFPL1MLz7DjG7VEHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Jason Wang <jasowang@redhat.com>
CC: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, David Airlie <airlied@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	=?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Robert
 Beckett <bob.beckett@collabora.com>, Mikhail Golubev-Ciuchea
	<Mikhail.Golubev-Ciuchea@opensynergy.com>, Parav Pandit <parav@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Stefano
 Stabellini <sstabellini@kernel.org>, =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?=
	<roger.pau@citrix.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Koenig, Christian" <Christian.Koenig@amd.com>, "Hildebrand, Stewart"
	<Stewart.Hildebrand@amd.com>, Xenia Ragiadakou <burzalodowa@gmail.com>,
	"Huang, Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia"
	<Julia.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Chen, Jiqian"
	<Jiqian.Chen@amd.com>
Thread-Topic: [virtio-dev] Re: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add
 freeze_mode to virtio_pci_common_cfg
Thread-Index:
 AQHZ6u53lm7slkvYHEmC01qhzu9Vn7AksLcAgACjFgCAANz/gIAAzyqAgAPgxwCAAg2+AA==
Date: Tue, 26 Sep 2023 02:23:53 +0000
Message-ID:
 <BL1PR12MB5849B427B23D1ED269808463E7C3A@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <CACGkMEuEXk2UzXU7sFUk-nHEeE7QoB3kbjnHgktY7KWuK71Xrg@mail.gmail.com>
 <BL1PR12MB58490A484087B2B2C37B6E43E7F8A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEtx-i_9dgdONFzEmmWYNRhaoJQZX7a5OmLfDvGoUaajPQ@mail.gmail.com>
 <BL1PR12MB5849E38DE89D80B8A4CB7128E7FFA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEv0d3frw9KJcC3qDs0p8ZeWg6dowNEHcAHsgaOTm4CAAQ@mail.gmail.com>
In-Reply-To:
 <CACGkMEv0d3frw9KJcC3qDs0p8ZeWg6dowNEHcAHsgaOTm4CAAQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: IA0PR12MB8349.namprd12.prod.outlook.com
 (15.20.6863.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|DM6PR12MB4976:EE_
x-ms-office365-filtering-correlation-id: cadbd48d-f2c4-44b4-b8cb-08dbbe37a0e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WyX9xnYCAztinnh5evXrNxAdEMemtWuqCYmwLzPLNBVkM5mVE3nr9NZBTJtEJTv08wy1dPmyJOmQfqLoUUWmn4n2QAmpZPDBWOrn0CC8QedomD6Tr0ARYJ9OhYloRxzZFg9fQGt01TQ7qThmpjThwRQHRhaB/ks5D3WWtqhQlnDj2QnFDFPE+QI4WAVn2KE01P9SLMlsamr2waIF+dqK7eDGRttCBZULdin9rCTafwsLwKhbhHIgKqnI8SM9cyi+nT0t385n6JVQ/C+TpCt2kS73G4xyNBV0ZNtxHkELdtKWlWJR73PImd+gMY951zvtFDmtmx/uorf8j9ZbAWxdB18uJ8H9Ti2uwot6/6HZjS8Z6FqTvFoUoOLmxWArI0PEpI2hbQ4wp7iM8TkRerJi4ozWTK7gi7cML+1yGqLPa8BX4svxu3yvsBBZ3Zgd8ijys8mSb2atovl3XBORPXo3lJO5YoiwckdjPn7E1Vh8EPithMKoG/qp96o1DBJbq1ht9FICMhg2l+menF2Vts7d6rOuL4AY9sAd/sagH1inFtzSdw+NvvMe2ojsYhxlauRXb8nJgym170PHqvM0VfXy6Skz7HhtATv1oPWy/av2uUM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(366004)(346002)(230922051799003)(1800799009)(186009)(451199024)(7696005)(26005)(6506007)(66899024)(53546011)(9686003)(122000001)(38070700005)(38100700002)(33656002)(55016003)(83380400001)(8676002)(8936002)(4326008)(316002)(6916009)(41300700001)(64756008)(66946007)(66476007)(54906003)(66446008)(66556008)(5660300002)(52536014)(76116006)(7416002)(2906002)(71200400001)(966005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QTlxMFBMZWZVakhadWdqQXdqbXZsUTAwcU9hY3FHRDRtMXdacFdCcm1QRWpn?=
 =?utf-8?B?UUFkS21MRkdCVDlzY08zMk5TdmhrYnlJeGwvdmQvQm43M1dML1V0cmhJRXpn?=
 =?utf-8?B?dVJ6OVl0R3dsRnM1MzlqV1FLY0tMRGUycFYzbDYrWEJLWjM2TncwT1N2TEk2?=
 =?utf-8?B?cHB1Q2NMSE5HTXlNUnB6bmJLaHpIT25KVVUzSHNyTS9iMko0eVFYQVo3dFhR?=
 =?utf-8?B?ZkYyTzdRT2JmWk1uQlF1RXRuY2JzVEVPbTVkeVdhMFZYSmJSTXBNQXU1eEdO?=
 =?utf-8?B?a3QySHJYRGV4Njg0aUFIMjFacEhTRVpnRkJveTF2bUk0YXhYRkNLSURSdnJD?=
 =?utf-8?B?SkxmVUJ1TytLdDN0U2hiOUJjbUVDMlhNR3JKRXpWQkxnZmdvYnZYb2hERWxB?=
 =?utf-8?B?YURPQjM5eFNrRkVCc1c4ZmI4RVJ1SUlybmZjcE1JS2Y2enlTckVaQldGVVFr?=
 =?utf-8?B?bHJlTDdhMDJ0eURJQWV4ZWhZdkRnWXpCZS9ZRTgxL3lFaWxITDg4VVZFcHNo?=
 =?utf-8?B?UjFXZmt3YmdXZHpNMWxBV04wNy9HUzB4QmV1M0Vrb0pIVGlPeDcwZkRsbG8y?=
 =?utf-8?B?ZUVkWStzVVo0Zyt1RFk2SFNFRzZ4S3ZmN1dSdXlGUS9Za1p2VXRWMmNXOUtZ?=
 =?utf-8?B?Um5MamJMUjloODNOWFhDL0pkbEFraHBNZlFzVmJJUkR5RlpGOHpVZWhUYVB0?=
 =?utf-8?B?eXhaamxDKytOMExyMDZ1MmFCMWZzRzhNb2xtaVRGcDZoZ0R2TTE4WFdUZG56?=
 =?utf-8?B?MHBUK2owbGFaNmJldmgrQ2JJS3FKc092OGlOOFhKR2lwSXRFU0ZYdWlDd3NV?=
 =?utf-8?B?K0RQMFVQZFV5VzFXRUxKZzQ1VlRrYlRNclJRODlOV1NjK0dBZFp0d0Z1blov?=
 =?utf-8?B?elB4dG1SYisrZ0xrZzJHV0d2TXNkTXZEREhUelIwSzUvZGU1a3kvM3l6VTg1?=
 =?utf-8?B?ZytqWUxNZ3NmS0o1eG9jT0pheFM0TmJTTnZLRy84R3p1aHpCTWwrVDAxUEpX?=
 =?utf-8?B?RDU0ZUF4NkdRaWJrUDhyZVJHTVd5R0FkQTBOd1ZIUFRTWnJLRUhHb2lGOVY5?=
 =?utf-8?B?T3NFc1NsR3BESFprUHovaXBRY1hrRzdwaWxHUmNuS1hQM29xV29FZ3pZNjZL?=
 =?utf-8?B?ZmN3U3lDRER6eUNFRHVTOXhJUC9hTHNyOGhBcUhBZU0xb2dSaUdqSWdIR056?=
 =?utf-8?B?dVFQRldRcmZMS0puRlFYSng2NjhJOXd5S0VQMEZTbXRyS1JBRzJNYktIVUFu?=
 =?utf-8?B?eXNJZWM0Nm14U0NTcjhMZk1NRThidkphSDRRcHJPQURmQXByOXN3a0I3QUhq?=
 =?utf-8?B?WEJ5UHhtNmRVQmdiMVkyQW5RRzFnelVWUHBYQVVkRTYybTZqVjE2cG1mYWty?=
 =?utf-8?B?c1ZUY1hONE9TR01UZkdZYnJvUEEzRmNhNk1hZmc1cE1MQWlsM2ZWTWRST1RI?=
 =?utf-8?B?NnV5SFNHRFA5djRkc0swWHkwK2I3a3hwVDVXOFVDWUIwMXFkVDRwMlpuQXBD?=
 =?utf-8?B?MWRDRmFtcU82SG9jNEQ5NTQ3RWpBTW1hKzlNM3dCUHNUa1o1QTRCdTh5bnBD?=
 =?utf-8?B?VW9pRXp2Mk5hUjhYT293ejhVc1ZOS1J1eTBDVC85VGRGY0xiUVJUNTlwdXlC?=
 =?utf-8?B?N21kTXBxQzNNWDljcUNFQTNZbGpEMUxLeG9zRlM4RFpjUFlJdExFK0YzQjBr?=
 =?utf-8?B?Z3F5RWRMVHNZNUxzU2NxTzR5dnh0YVBKa1pKa1BTdmFxTzVMakd3MXdXSlNs?=
 =?utf-8?B?RFhhWjZJRnNkalkzUDM4YWsyYi8yTGdLb0lJYm9INFdDWk5jT1JsK0ZkVFNO?=
 =?utf-8?B?MUY5R2Z1R0hFZEpVUCtCaGRNS1pFM2VOd3dNMXlaSmJON0t2bHh6SmVSdmRh?=
 =?utf-8?B?NEsybDBFdGR0TWpVSlpHM1BCa3Z3aENrUWhaVHVQQ2pwODBON0Z0OEt4ejll?=
 =?utf-8?B?SmdPcjhXSmNPNDRmMTcwWGdLZXQ3amRsYkdLOW90dGZhUUNmNmhReG05Ums4?=
 =?utf-8?B?Zk55VEIvWTlocDFCTXVqU2JqU2J6TFA5TTQ0UCtNelRyMXFQV2pIUnkwK3pr?=
 =?utf-8?B?ait1QW5mSnNNd29jd2RGYUgxUWRBZytDMEJtWkJCZUtNcDhIZjFGWUswYUt5?=
 =?utf-8?Q?/8WQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F857633AF6E81843B83B3757C81E293B@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cadbd48d-f2c4-44b4-b8cb-08dbbe37a0e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 02:23:53.4843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g8CcefV44sjUphKUK+wooVfEHh1dDcYBbE2fIgKZ7Fa9ayEypadSmSGQCKJq4aKhrzipSCdVLDJ3GekuveaaEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4976
Subject: Re: [virtio-dev] Re: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add
 freeze_mode to virtio_pci_common_cfg

T24gMjAyMy85LzI1IDEwOjUyLCBKYXNvbiBXYW5nIHdyb3RlOg0KPiBPbiBGcmksIFNlcCAyMiwg
MjAyMyBhdCA0OjA34oCvUE0gQ2hlbiwgSmlxaWFuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPiB3cm90
ZToNCj4+DQo+PiBIaSBKYXNvbiwNCj4+DQo+PiBPbiAyMDIzLzkvMjIgMTE6MTcsIEphc29uIFdh
bmcgd3JvdGU6DQo+Pj4gT24gVGh1LCBTZXAgMjEsIDIwMjMgYXQgMjoyOOKAr1BNIENoZW4sIEpp
cWlhbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4gd3JvdGU6DQo+Pj4+DQo+Pj4+IEhpIEphc29uLA0K
Pj4+Pg0KPj4+PiBPbiAyMDIzLzkvMjEgMTI6MjIsIEphc29uIFdhbmcgd3JvdGU6DQo+Pj4+PiBP
biBUdWUsIFNlcCAxOSwgMjAyMyBhdCA3OjQz4oCvUE0gSmlxaWFuIENoZW4gPEppcWlhbi5DaGVu
QGFtZC5jb20+IHdyb3RlOg0KPj4+Pj4+DQo+Pj4+Pj4gV2hlbiBndWVzdCB2bSBkb2VzIFMzLCBR
ZW11IHdpbGwgcmVzZXQgYW5kIGNsZWFyIHNvbWUgdGhpbmdzIG9mIHZpcnRpbw0KPj4+Pj4+IGRl
dmljZXMsIGJ1dCBndWVzdCBjYW4ndCBhd2FyZSB0aGF0LCBzbyB0aGF0IG1heSBjYXVzZSBzb21l
IHByb2JsZW1zLg0KPj4+Pj4+IEZvciBleGNhbXBsZSwgUWVtdSBjYWxscyB2aXJ0aW9fcmVzZXQt
PnZpcnRpb19ncHVfZ2xfcmVzZXQgd2hlbiBndWVzdA0KPj4+Pj4+IHJlc3VtZSwgdGhhdCBmdW5j
dGlvbiB3aWxsIGRlc3Ryb3kgcmVuZGVyIHJlc291cmNlcyBvZiB2aXJ0aW8tZ3B1LiBBcw0KPj4+
Pj4+IGEgcmVzdWx0LCBhZnRlciBndWVzdCByZXN1bWUsIHRoZSBkaXNwbGF5IGNhbid0IGNvbWUg
YmFjayBhbmQgd2Ugb25seQ0KPj4+Pj4+IHNhdyBhIGJsYWNrIHNjcmVlbi4gRHVlIHRvIGd1ZXN0
IGNhbid0IHJlLWNyZWF0ZSBhbGwgdGhlIHJlc291cmNlcywgc28NCj4+Pj4+PiB3ZSBuZWVkIHRv
IGxldCBRZW11IG5vdCB0byBkZXN0cm95IHRoZW0gd2hlbiBTMy4NCj4+Pj4+Pg0KPj4+Pj4+IEZv
ciBhYm92ZSBwdXJwb3NlLCB3ZSBuZWVkIGEgbWVjaGFuaXNtIHRoYXQgYWxsb3dzIGd1ZXN0cyBh
bmQgUUVNVSB0bw0KPj4+Pj4+IG5lZ290aWF0ZSB0aGVpciByZXNldCBiZWhhdmlvci4gU28gdGhp
cyBwYXRjaCBhZGQgYSBuZXcgcGFyYW1ldGVyDQo+Pj4+Pj4gbmFtZWQgZnJlZXplX21vZGUgdG8g
c3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2NmZy4gQW5kIHdoZW4gZ3Vlc3QNCj4+Pj4+PiBzdXNw
ZW5kcywgaXQgY2FuIHdyaXRlIGZyZWV6ZV9tb2RlIHRvIGJlIEZSRUVaRV9TMywgYW5kIHRoZW4g
dmlydGlvDQo+Pj4+Pj4gZGV2aWNlcyBjYW4gY2hhbmdlIHRoZWlyIHJlc2V0IGJlaGF2aW9yIG9u
IFFlbXUgc2lkZSBhY2NvcmRpbmcgdG8NCj4+Pj4+PiBmcmVlemVfbW9kZS4gV2hhdCdzIG1vcmUs
IGZyZWV6ZV9tb2RlIGNhbiBiZSB1c2VkIGZvciBhbGwgdmlydGlvDQo+Pj4+Pj4gZGV2aWNlcyB0
byBhZmZlY3QgdGhlIGJlaGF2aW9yIG9mIFFlbXUsIG5vdCBqdXN0IHZpcnRpbyBncHUgZGV2aWNl
Lg0KPj4+Pj4NCj4+Pj4+IEEgc2ltcGxlIHF1ZXN0aW9uLCB3aHkgaXMgdGhpcyBpc3N1ZSBzcGVj
aWZpYyB0byBwY2k/DQo+Pj4+IEkgdGhvdWdodCB5b3UgcG9zc2libHkgbWlzc2VkIHRoZSBwcmV2
aW91cyB2ZXJzaW9uIHBhdGNoZXMuIEF0IHRoZSBiZWdpbm5pbmcsIEkganVzdCB3YW50ZWQgdG8g
YWRkIGEgbmV3IGZlYXR1cmUgZmxhZyBWSVJUSU9fR1BVX0ZfRlJFRVpFX1MzIGZvciB2aXJ0aW8t
Z3B1IHNpbmNlIEkgZW5jb3VudGVyZWQgdmlydGlvLWdwdSBpc3N1ZSBkdXJpbmcgZ3Vlc3QgUzMs
IHNvIHRoYXQgdGhlIGd1ZXN0IGFuZCBxZW11IGNhbiBuZWdvdGlhdGUgYW5kIGNoYW5nZSB0aGUg
cmVzZXQgYmVoYXZpb3IgZHVyaW5nIFMzLiBCdXQgUGFyYXYgYW5kIE1pa2hhaWwgaG9wZWQgbWUg
Y2FuIGltcHJvdmUgdGhlIGZlYXR1cmUgdG8gYSBwY2kgbGV2ZWwsIHRoZW4gb3RoZXIgdmlydGlv
IGRldmljZXMgY2FuIGFsc28gYmVuZWZpdCBmcm9tIGl0LiBBbHRob3VnaCBJIGFtIG5vdCBzdXJl
IGlmIGV4cGFuZGluZyBpdHMgaW5mbHVlbmNlIGlzIGFwcHJvcHJpYXRlLCBJIGhhdmUgbm90IHJl
Y2VpdmVkIGFueSBmZWVkYmFjayBmcm9tIG90aGVycywgc28gSSBjaGFuZ2UgaXQgdG8gdGhlIHBj
aSBsZXZlbCBhbmQgbWFkZSB0aGlzIHZlcnNpb24uDQo+Pj4+IElmIHlvdSBhcmUgaW50ZXJlc3Rl
ZCwgcGxlYXNlIHNlZSB0aGUgcHJldmlvdXMgdmVyc2lvbjogaHR0cHM6Ly9saXN0cy5vYXNpcy1v
cGVuLm9yZy9hcmNoaXZlcy92aXJ0aW8tY29tbWVudC8yMDIzMDcvbXNnMDAyMDkuaHRtbCwgdGhh
bmsgeW91Lg0KPj4+DQo+Pj4gVGhpcyBpcyBub3QgYSBnb29kIGFuc3dlci4gTGV0IG1lIGFzayB5
b3UgZGlmZmVyZW50bHksIHdoeSBkb24ndCB5b3UNCj4+PiBzZWUgaXQgaW4gb3RoZXIgZm9ybXMg
b2YgdHJhbnNwb3J0IGxpa2UgdmlydGlvLWdwdS1tbWlvPw0KPj4gU29ycnkgZm9yIG5vdCB1bmRl
cnN0YW5kaW5nIHlvdXIgcXVlc3Rpb24gYmVmb3JlLiBEaWQgeW91IG1lYW4gd2h5IGRpZCBJIGFk
ZCBmcmVlemVfbW9kZSBmb3IgdmlydGlvLXBjaSB0eXBlIGRldmljZXMgaW5zdGVhZCBvZiB2aXJ0
aW8tbW1pbyB0eXBlIGRldmljZXM/DQo+IA0KPiBZZXMuDQo+IA0KPj4gSWYgdGhhdCdzIHRoZSBj
YXNlLCBpdCBpc24ndCB3ZWxsIHRob3VnaHQgb3V0IGJ5IG1lLCBiZWNhdXNlIHRoZXJlIGlzIG9u
bHkgdmlydGlvLWdwdSB3aXRoIHBjaSBzdXBwb3J0IGluIG15IGVudmlyb25tZW50LCBzbyBJLCBh
cyBhIG1hdHRlciBvZiBjb3Vyc2UsIGltcHJvdmUgaXQgZnJvbSB2aXJ0aW8tZ3B1LXBjaSB0byBh
IHZpcnRpby1wY2kgbGV2ZWwgaW5zdGVhZCBvZiB2aXJ0aW8tbW1pby4NCj4+IERvIHlvdSB0aGlu
ayBJIG5lZWQgdG8gYWRkIGZyZWV6ZV9tb2RlIGZvciB2aXJ0aW8tbW1pbyB0b28/DQo+IA0KPiBC
ZWNhdXNlIHRoZSBmdW5jdGlvbiB5b3UgZGVzY3JpYmUgaXMgdG8gcHJlc2VydmUgdGhlIHJlbmRl
ciByZXNvdXJjZXMNCj4gd2hpY2ggaGF2ZSBub3RoaW5nIHNwZWNpZmljIHRvIFBDSS4gSXQncyBh
IGNvcmUgdmlydGlvIGZ1bmN0aW9uLg0KPiANCj4gSSdkIHN1Z2dlc3QgZml4aW5nIGl0IGF0IHRo
ZSB2aXJ0aW8gbGV2ZWwgaW5zdGVhZCBvZiBQQ0kgbGV2ZWwuDQpZZXMsIHlvdSBhcmUgcmlnaHQs
IEkgd2lsbCBjaGFuZ2UgdG8gZGVzY3JpYmUgaXQgdG8gdGhlIHZpcnRpbyBsZXZlbCBpbiBuZXh0
IHZlcnNpb24uDQoNCj4gDQo+PiBPciBpbXByb3ZlIGl0IHRvIGEgaGlnaGVyIGxldmVsLCBsaWtl
IHZpcnRpby1idXM/IEkgYW0gbG9va2luZyBmb3J3YXJkIHRvIGdldHRpbmcgeW91ciBzdWdnZXN0
aW9ucywgdGhhbmtzLg0KPiANCj4gQXMgcG9pbnRlZCBvdXQgaW4gb3RoZXIgdGhyZWFkLCByZXVz
aW5nIHRoZSBleGlzdGluZyBzdGF0dXMgc3RhdGUNCj4gbWFjaGluZSBpcyBhIHBlcmZlY3Qgd2F5
IGZvciBkb2luZyB0aGlzLg0KPiANCj4gV2UgY2FuIHR3ZWFrIHRoZSBzdGF0ZSBtYWNoaW5lIHRv
IGJlIGFibGUgdG8gZG8gYm90aCBtaWdyYXRpb24gYW5kIFMzLg0KSSBub3RpY2VkIHRoZSBvdGhl
ciB0aHJlYWQgeW91IHNhaWQsIGl0IHdpbGwgYWRkIGEgU1VTUEVORCBzdGF0dXMgdG8gaW50byBk
ZXZpY2Vfc3RhdHVzIGZpZWxkLCBidXQgaXQgc2VlbXMgbm90IGVub3VnaCB0byBtZWV0IGFsbCBz
Y2VuYXJpb3MsIGxpa2Ugd2UgbmVlZCB0byBzZXQgdGhlIHVuZnJlZXplIHN0YXRlIG9mIGd1ZXN0
LCB0aGUgUzMgc3RhdGUgb2YgdGhlIGd1ZXN0LCB0aGUgUzQgc3RhdGUgb2YgdGhlIGd1ZXN0IGV0
Yy4gU28sIG9uZSBiaXQgaXMgbm90IGVub3VnaCB0byBpbmRpY2F0ZSB3aGF0IHN0YXR1cyB0aGUg
Z3Vlc3QgaXMsIHNpbmNlIHRoZSBmcmVlemUgbW9kZSBpcyBhIHNlcmllcywgSSB0aGluayBhZGQg
YSBuZXcgZmllbGQgdG8gZGVzY3JpYmUgaXQgaXMgbW9yZSByZWFzb25hYmxlLg0KDQo+IA0KPiBU
aGFua3MNCj4gDQo+Pg0KPj4+DQo+Pj4gVGhhbmtzDQo+Pj4NCj4+Pj4NCj4+Pj4+DQo+Pj4+PiBU
aGFua3MNCj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4+DQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogSmlxaWFu
IENoZW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+Pj4+Pj4gLS0tDQo+Pj4+Pj4gIHRyYW5zcG9y
dC1wY2kudGV4IHwgNyArKysrKysrDQo+Pj4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlv
bnMoKykNCj4+Pj4+Pg0KPj4+Pj4+IGRpZmYgLS1naXQgYS90cmFuc3BvcnQtcGNpLnRleCBiL3Ry
YW5zcG9ydC1wY2kudGV4DQo+Pj4+Pj4gaW5kZXggYTVjNjcxOS4uMjU0MzUzNiAxMDA2NDQNCj4+
Pj4+PiAtLS0gYS90cmFuc3BvcnQtcGNpLnRleA0KPj4+Pj4+ICsrKyBiL3RyYW5zcG9ydC1wY2ku
dGV4DQo+Pj4+Pj4gQEAgLTMxOSw2ICszMTksNyBAQCBcc3Vic3Vic2VjdGlvbntDb21tb24gY29u
ZmlndXJhdGlvbiBzdHJ1Y3R1cmUgbGF5b3V0fVxsYWJlbHtzZWM6VmlydGlvIFRyYW5zcG9ydA0K
Pj4+Pj4+ICAgICAgICAgIGxlNjQgcXVldWVfZGVzYzsgICAgICAgICAgICAgICAgLyogcmVhZC13
cml0ZSAqLw0KPj4+Pj4+ICAgICAgICAgIGxlNjQgcXVldWVfZHJpdmVyOyAgICAgICAgICAgICAg
LyogcmVhZC13cml0ZSAqLw0KPj4+Pj4+ICAgICAgICAgIGxlNjQgcXVldWVfZGV2aWNlOyAgICAg
ICAgICAgICAgLyogcmVhZC13cml0ZSAqLw0KPj4+Pj4+ICsgICAgICAgIGxlMTYgZnJlZXplX21v
ZGU7ICAgICAgICAgICAgICAgLyogcmVhZC13cml0ZSAqLw0KPj4+Pj4+ICAgICAgICAgIGxlMTYg
cXVldWVfbm90aWZfY29uZmlnX2RhdGE7ICAgLyogcmVhZC1vbmx5IGZvciBkcml2ZXIgKi8NCj4+
Pj4+PiAgICAgICAgICBsZTE2IHF1ZXVlX3Jlc2V0OyAgICAgICAgICAgICAgIC8qIHJlYWQtd3Jp
dGUgKi8NCj4+Pj4+Pg0KPj4+Pj4+IEBAIC0zOTMsNiArMzk0LDEyIEBAIFxzdWJzdWJzZWN0aW9u
e0NvbW1vbiBjb25maWd1cmF0aW9uIHN0cnVjdHVyZSBsYXlvdXR9XGxhYmVse3NlYzpWaXJ0aW8g
VHJhbnNwb3J0DQo+Pj4+Pj4gIFxpdGVtW1xmaWVsZHtxdWV1ZV9kZXZpY2V9XQ0KPj4+Pj4+ICAg
ICAgICAgIFRoZSBkcml2ZXIgd3JpdGVzIHRoZSBwaHlzaWNhbCBhZGRyZXNzIG9mIERldmljZSBB
cmVhIGhlcmUuICBTZWUgc2VjdGlvbiBccmVme3NlYzpCYXNpYyBGYWNpbGl0aWVzIG9mIGEgVmly
dGlvIERldmljZSAvIFZpcnRxdWV1ZXN9Lg0KPj4+Pj4+DQo+Pj4+Pj4gK1xpdGVtW1xmaWVsZHtm
cmVlemVfbW9kZX1dDQo+Pj4+Pj4gKyAgICAgICAgVGhlIGRyaXZlciB3cml0ZXMgdGhpcyB0byBz
ZXQgdGhlIGZyZWV6ZSBtb2RlIG9mIHZpcnRpbyBwY2kuDQo+Pj4+Pj4gKyAgICAgICAgVklSVElP
X1BDSV9GUkVFWkVfTU9ERV9VTkZSRUVaRSAtIHZpcnRpby1wY2kgaXMgcnVubmluZzsNCj4+Pj4+
PiArICAgICAgICBWSVJUSU9fUENJX0ZSRUVaRV9NT0RFX0ZSRUVaRV9TMyAtIGd1ZXN0IHZtIGlz
IGRvaW5nIFMzLCBhbmQgdmlydGlvLXBjaSBlbnRlcnMgUzMgc3VzcGVuc2lvbjsNCj4+Pj4+PiAr
ICAgICAgICBPdGhlciB2YWx1ZXMgYXJlIHJlc2VydmVkIGZvciBmdXR1cmUgdXNlLCBsaWtlIFM0
LCBldGMuDQo+Pj4+Pj4gKw0KPj4+Pj4+ICBcaXRlbVtcZmllbGR7cXVldWVfbm90aWZfY29uZmln
X2RhdGF9XQ0KPj4+Pj4+ICAgICAgICAgIFRoaXMgZmllbGQgZXhpc3RzIG9ubHkgaWYgVklSVElP
X0ZfTk9USUZfQ09ORklHX0RBVEEgaGFzIGJlZW4gbmVnb3RpYXRlZC4NCj4+Pj4+PiAgICAgICAg
ICBUaGUgZHJpdmVyIHdpbGwgdXNlIHRoaXMgdmFsdWUgd2hlbiBkcml2ZXIgc2VuZHMgYXZhaWxh
YmxlIGJ1ZmZlcg0KPj4+Pj4+IC0tDQo+Pj4+Pj4gMi4zNC4xDQo+Pj4+Pj4NCj4+Pj4+DQo+Pj4+
Pg0KPj4+Pj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4+PiBUbyB1bnN1YnNjcmliZSwgZS1tYWlsOiB2aXJ0
aW8tZGV2LXVuc3Vic2NyaWJlQGxpc3RzLm9hc2lzLW9wZW4ub3JnDQo+Pj4+PiBGb3IgYWRkaXRp
b25hbCBjb21tYW5kcywgZS1tYWlsOiB2aXJ0aW8tZGV2LWhlbHBAbGlzdHMub2FzaXMtb3Blbi5v
cmcNCj4+Pj4+DQo+Pj4+DQo+Pj4+IC0tDQo+Pj4+IEJlc3QgcmVnYXJkcywNCj4+Pj4gSmlxaWFu
IENoZW4uDQo+Pj4NCj4+DQo+PiAtLQ0KPj4gQmVzdCByZWdhcmRzLA0KPj4gSmlxaWFuIENoZW4u
DQo+IA0KPiANCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IFRvIHVuc3Vic2NyaWJlLCBlLW1haWw6IHZpcnRp
by1kZXYtdW5zdWJzY3JpYmVAbGlzdHMub2FzaXMtb3Blbi5vcmcNCj4gRm9yIGFkZGl0aW9uYWwg
Y29tbWFuZHMsIGUtbWFpbDogdmlydGlvLWRldi1oZWxwQGxpc3RzLm9hc2lzLW9wZW4ub3JnDQo+
IA0KDQotLSANCkJlc3QgcmVnYXJkcywNCkppcWlhbiBDaGVuLg0K

