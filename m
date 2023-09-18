Return-Path: <virtio-dev-return-13786-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF33CD37B0
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 04:42:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4BF9661274
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 04:42:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3DCF9986637
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 04:42:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 31D639863AD; Mon, 18 Sep 2023 04:42:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1F8D598638E;
	Mon, 18 Sep 2023 04:42:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4MHs28keb5f61cbWHE1KILIOYcDnF1Las3io7AN9L13blu7gVjkXkcgDKScmjJiwwYAMF/Us10sJCpdCHNWmEAPa/ajwRgvpDLHdxD7HB5IKE4C2IOlhZ3aQgMRjR8dtcrImkkJ5+j0XRr1t75iuPB1DsQfzG1zdfwr08m5AwRfVxZu9LUwkZeinKTauTcsQJceHEUz/l7tr5+/PyWXI+NuHrVxUGdQcJwjEfuTXr7W0+M163IbqQsibuqUhB5bpgaGsWul+dgSHqZwVUMPe7dB2ct5gwmMVqs8ATFGFKBs0sPh71i3lJJ0DeBQl0JbbkJI0i/8EzZyGOwed7YUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0UWnaqzK0jhyO5B4eUsh7wWYgoNLv5fJHQmCdNuxfI=;
 b=Fe6kq5imap8pirdibieSixH8vV5s4bfPH2UP0nkMtqIVJkpJVG19RiyfMxH41Rh25hbmIJlh65AluPAwCNaN2i1ZURTweQEykK0r5/A/CHVp1TpFl75VAqSPzXuomwY6HJf+D4YcRERR74u6j4GmgghbZNp33C2xvTeETwfbMI5EmFfiHgqecRgzRDmvQ0JBlxPQsriVhLz/yCdJzB/ZwIixLPUsdVnsPYXzH5Z58UFl33gvgdHFxIwF47FgJbjN5TvUBj6EdmU6FlMrtfe++7zwpWG8wpQjJJTeBnNk2BTMaSQ5yaPmMTkslYJG9pLzIq8R9y7DMrZsoXQb4lKjhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, "Michael S. Tsirkin"
	<mst@redhat.com>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "eperezma@redhat.com"
	<eperezma@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] Re: [PATCH 2/5] virtio: introduce SUSPEND bit
 in device status
Thread-Index: AQHZ54Brxw1ek7h0hUC1WdnFAMp2C7Abu4+AgAQs4gCAAB0UEA==
Date: Mon, 18 Sep 2023 04:42:29 +0000
Message-ID:
 <PH0PR12MB5481E091659FEA931DBC826EDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-3-lingshan.zhu@intel.com>
 <20230914073023-mutt-send-email-mst@kernel.org>
 <258989c9-8c5f-c72e-c03d-aabf11f9823d@intel.com>
 <20230915070504-mutt-send-email-mst@kernel.org>
 <3ff7e79f-8fbb-4e3e-eb12-17ed8943fe6f@intel.com>
In-Reply-To: <3ff7e79f-8fbb-4e3e-eb12-17ed8943fe6f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY8PR12MB7489:EE_
x-ms-office365-filtering-correlation-id: a25db512-0643-4d79-1502-08dbb801aa79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 63eJjN/5dWEKjQz/a7xcEkONXTHwKyMwjDLXjBvol1ZBkcwkZ+YJcs7OblP3FryjvfiaFohkMPjlE9FcwL/ONMa9+0Y8GSWrdY3LRFKlSxaEDneXlmPi7aOEH5a3jy81YsimYwxVgol3YbaiActFqNrYgORN8hHRdD5J2er9a7nBs0zGJ07kH0PgXmzLL9sJoCYmFB6KOD+mYloI1UjyAlUooKM1hTvol8ROqCsSq2769ccvJijtvSGAF48RncZeNfT95WtRFz+ChdCB+Dg5XIG/CxuQic+TpQVV8DxSGqFESvhcCh8w8Oog94+ADZGez+pptsi1TDm+bodEVYBh9P0w2FtBxIOp4KU9wRsuCHoPBpd3xbvTv7biB7ssklnEgS2PWeOyA0YxomJW6QwQ8ukgKvFcuNg3nomgTs45vvYeWGNgw7huPpWcEu7mKn057z45026u/AShf67MkwKnXRjJlzLknSIMLHToI4sQ33IOehuNnebisfDQCmxC9gSjQPbG1Aibl9oX1LPmEpiplajlNh+GXmp78LTmZrLpCMog+NZhIxih98PPdoXk9xreOkPDwAb7x7YtLPeGMgxY6Y1CJ9Uh237NZR9pBkI83aMQUPGar/1jhLT3VZp+wiWD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199024)(1800799009)(186009)(83380400001)(26005)(71200400001)(55016003)(4744005)(9686003)(6506007)(7696005)(2906002)(55236004)(478600001)(122000001)(15650500001)(38070700005)(110136005)(41300700001)(33656002)(38100700002)(76116006)(54906003)(66476007)(66446008)(316002)(64756008)(66946007)(8936002)(8676002)(66556008)(5660300002)(86362001)(52536014)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WStETnZreHFmNFdIaWRzc21uQUFkTWJzM25uZVI5RldZenFRWWp1eUtISUJZ?=
 =?utf-8?B?TmwrYXpWejdVT3VuT1JkVGVyYmxuMlR1SmM2dnVMaXdTbitjbG9FRldRdmJJ?=
 =?utf-8?B?OFRVZFozTFZnajNoSXYwaFNuNHh1aFJPL2pJOFNvT0IzSkE2eG9kRzZobDZL?=
 =?utf-8?B?Vis0bGFFYXRQa2NkN1RkRHB0VkVBbHdKUlVNVklsdWFMbkdIZW1ObFo1d1Vu?=
 =?utf-8?B?ZkpjQjdUMTFoUHV5LzlFS2kzRDBFREdkMW5zSzExY1I1bkgrY1pTZEVtL0pN?=
 =?utf-8?B?RzIyT25McEZxcXdzYVJUcjNibnVTMkZXK0FvNzBQcXN4TXpiYzNxdGZmNXNL?=
 =?utf-8?B?SDNSeG1ydGw1VmtZZ1pMQWcxY20wdXpxODlJMWRJb0IzdTl1UU13cG9aT3VD?=
 =?utf-8?B?OVRreW5WU3VvczdxdU9TQTFhNm1zdSsyOHJzR3QyU2s3ejRTbGszOVpuSW8z?=
 =?utf-8?B?QzhROC80ckZKVFBFS284dDhnWUtHQ3cyYjU1d0dXMVdrVlpYcnNNMlNCOTI0?=
 =?utf-8?B?d1NwMERXMFBZTDZ4TEcyMUQrbk93amlqVnBOTlNkaHNZbWdzczl3eWJOdURx?=
 =?utf-8?B?M1FZNWdkMnB4RlI2WXZEN1JlWWI4UlhZYk0wTXpuMUJTeSt6NThnTmozSkRO?=
 =?utf-8?B?YjVGcVEvWHowSDBNVFgvTE45M1RDcldFTHFPL1VtY3Jqc3FFZUdaeUE4ZnBl?=
 =?utf-8?B?aWlMR1ZLTVVVMkJPTTBOR0ptMkxBdTlSLzZ4alRwcmd4V2hKTW9tNThtR3ZF?=
 =?utf-8?B?b25xOEZCa2dxdFB0S21KdjBWQU5jQk4wZG00RFBjWkFWWTY4MFhXR0NrYzQy?=
 =?utf-8?B?bUE4d0MrTndkL1hNNmNuUGtkTjdMY1czaXhhaGo4clZraHhLd1grcnpRcTha?=
 =?utf-8?B?N0hXbVg3YWJDZ2l3endFcW44MmtZUFFlbVJ2YWZLL2ZuRmp1TVRodlBBeFRq?=
 =?utf-8?B?L3FVUVRyVDFzamVXcmc4amlmcXQyVGsyQWtnS1p2VnE5NURMTVF0amgvK3lu?=
 =?utf-8?B?TWZZZVkrS3BlYnRDdHpiNHgwQzhrYWZGWGVPdno3YnhmSjdUMDNOamJzaFAz?=
 =?utf-8?B?Z1VZWlBPcWlnR2N4YTU3RVliTSs5SXZjemhGN3JxYURDdklRbWUzaW82Z1ky?=
 =?utf-8?B?dHhRQ21xemozdmNWL3VJOHFjTjZNOFZFa3R5TXdocVF4bUQvRjZxbktRckRn?=
 =?utf-8?B?UjdaNURmc3ZpUnhmOENDT0RrV0hvWUFXeE04SXZoM2ZoVEdPZEhLVFVVckx4?=
 =?utf-8?B?dFlUUkNUUnZMdGdEKzU1Um1Pd2xlWDdHak4yd2RrUGdwZlNlV3R3MW1lZDVV?=
 =?utf-8?B?T1RqcDV3RHp0MDQyYVpXQzFWcXJROU5GNWcwSk1GYjZMMXJvdzMzN2VmRW9O?=
 =?utf-8?B?K0NPSU1NNCtMRGFQQlkwSGFzWWxjYVJQTDFGaC9ickYrQ3ZyZWdDOXpMRnAx?=
 =?utf-8?B?VkJlRXBaSlZqYXBxY3g2ZU4yblh1eFRodk9YemhVNE43QWRJSkhWekZKRkxQ?=
 =?utf-8?B?NTNqTFhvbVc4djZyd3dUT2J4dDQwcjJvRlllcEtsYSt3TUw0WDJKS3ZlZjdT?=
 =?utf-8?B?YjJJYzhMM2FXTmVaTjBXLzZzYnNBWTkzbWtJTnNOaVNuNnAyZWZla0ZNZDUy?=
 =?utf-8?B?VGYzK3c5NVl0NVNuZ1Y1UTNQRWZZUVpSeThNeURBR04rWjFpUlRHTHRVa3BZ?=
 =?utf-8?B?RDc1aytxZExuNEdyelh1bXhBQ09oMHlQWHlWdTViMXc4QXF6MEg1ZTNlZC9l?=
 =?utf-8?B?aWRNc0puamhTczR4MWhXVXVqRkpmQ1NrRUFDRU85NENlaFJ4Q2x5OWloUUlv?=
 =?utf-8?B?QkZVUzVaVU5ETS9xeU56cjEwQ1lsa1dhOUtDQVJwVnE3WWtJTXZHaWVXc1Yr?=
 =?utf-8?B?WWdBRlhtNHFwcjhoWDlGNURhUXN3WVE5YVh0SGdCRUVHK09Ub2dOc3Z0Sk11?=
 =?utf-8?B?S29XY0pTVVUwWHFLRVZKOVduMTJ3V0E3bDVJVUpkdHVueis4QmdMVUJXZmRQ?=
 =?utf-8?B?V2REV3hvamlETHl4dURMMi9RVWRUd0wwNDRDMU9lV0dwMjdEZDNNZGxXQkJr?=
 =?utf-8?B?WDFrNkV5T2pSdnpaZW1kTDNMWVliemlCa0I5d2lKNHdnZHZuUWpWbExDT1BG?=
 =?utf-8?Q?28lA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a25db512-0643-4d79-1502-08dbb801aa79
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 04:42:29.7569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y6LjkKCFjRoGlPEATA3ipA6fdLawM/Mwk8Z83zKa61QbVSGqVzWaY3N5KJKJSlm7DU21x1RIn654QRyKrgMSAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 2/5] virtio: introduce SUSPEND bit in
 device status

DQo+IEZyb206IHZpcnRpby1jb21tZW50QGxpc3RzLm9hc2lzLW9wZW4ub3JnIDx2aXJ0aW8tY29t
bWVudEBsaXN0cy5vYXNpcy0NCj4gb3Blbi5vcmc+IE9uIEJlaGFsZiBPZiBaaHUsIExpbmdzaGFu
DQo+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDE4LCAyMDIzIDg6MjcgQU0NCg0KDQo+IGEgbmV3
IGZlYXR1cmUgYml0OiBWSVJUSU9fRl9SSU5HX1NVU1BFTkRfUkVTRVQuIElmIHRoaXMgZmVhdHVy
ZSBiaXQgaGFzIGJlZW4NCj4gbmVnb3RpYXRlZCB0aGVuIHRoZSBkZXZpY2UgYWxsb3cgcmVzZXQg
YSB2cSBhZnRlciBTVVNQRU5ELg0KDQpUaGlzIGlzIHNpbXBseSBhIHdyb25nIHNlbWFudGljcyB0
byBidWlsZCB0byBvcGVyYXRlIGluZGl2aWR1YWwgb2JqZWN0IGFmdGVyIGl0cyBwYXJlbnQgb2Jq
ZWN0IGlzIHN1c3BlbmRlZC4NCg==

