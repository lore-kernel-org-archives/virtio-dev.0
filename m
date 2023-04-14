Return-Path: <virtio-dev-return-12218-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593D9C77B6E
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 02:43:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B4C7029FD3
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 02:43:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A993C986637
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 02:43:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9D5EE983C98; Fri, 14 Apr 2023 02:43:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8C105986600;
	Fri, 14 Apr 2023 02:43:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZpg/ucLCRGYnnI6bjiQZi3aFful9ohBVNBQeQxmGh2DIUizuAF3qh+ONQuCuK5W15tcWc/pO4G2FGG6Ke+teZ1RQOnyIb8yQPHF55KCr+g9Zvw5oSM5SIf/q/mGk8Ue41LzZfDmypCzJk3etwU0WdlDhLKCh//7taMMfUnt+Pvc2CAU+BvZoBxnUlcYFx0vbquGhvAcKvjUeO/DK/ufWCBMR+s6ZemSg/dNWNdbdrUvlzoHNwraopGR1DirrI+DQleCIe8ZPryA5YOht0esUlNMZ8qO6G0mtwY0n6IWBVxL6hSMdlBp+uXiotkJQ54DD1Wwe5fe5nAmlUY5hBP3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O73n+cHx0J4RyV3rAXmpDlbZAZKhkpEHIatUlCmacHk=;
 b=I9bcSI+RAjdG+38QixbGCCFjRsKEoQBjLbbqCmQ7sSRs0dv7EIcFye4tTHK+Gl3vUDAsNc71Bo5b1h4b73CkS+M+RntkDgFhmc+Zri7UAmQBbYNicU3Uc432PZ/d19GmntG3+wgGTxGEd/5xTG+dJ01+rtSM8KOM4uG4N03A+9KJaC9VNRUF/GjaB1ZuufYAKvb3l1SNQT92J4WQzdXFXWDme4yfULB/vIqSY4p9tW/oQT2+Vf1doLzFZX/oJCl3dy0BDWbETLL5PR68MbyG7ltqRA0S3jfisxikk5IF0HwSYk1I+Wxh/d5nKuJzBJfUTFuS/Rq7P5D39SiG3xG5dA==
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
 AQHZY1tLAUtRpuZtUUOucQPGJlFfkK8flpUAgAQ7nwCAAE6hgIAAAXwAgAAFegCAAAt0AIAALl6AgAEOIwCAAFEgAIAAIPWAgAAcJ4CAASFtgIAABJ4AgAAKJYCAAACFsIAABgyAgAAAT3CAAAYpAIAAAJIAgAAJz4CAAILBcIAAxPiAgAAc1wCAABy4gIAAzAAAgAA85gCAAABI8IAAXS4AgAAARpA=
Date: Fri, 14 Apr 2023 02:43:21 +0000
Message-ID:
 <PH0PR12MB5481EEEE5BFE68CDC6628455DC999@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <CACGkMEvYsz1fSPG+fKpRaZ05Ut7ffKwvMPvR8xbRBsXA_6vGQw@mail.gmail.com>
 <PH0PR12MB548137D7A25C99EAA42B4D12DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshW82qztmGw8YJWJ8=QCoRd6cPxQ+ySazxsO_o+U6c4Q@mail.gmail.com>
 <PH0PR12MB548147CF939CB9C2A0586310DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu2B_GogDR9HUwB7mT8fkGh+Q_buPLz4nhwhK7h9k6BQQ@mail.gmail.com>
 <PH0PR12MB5481F0CF5A555A6BB2CE856CDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuNOYOxvcSzrs0UFEyk+xOkGUpOfhK8rOy_Mebz5b5wdg@mail.gmail.com>
 <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com>
 <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
 <f9f01f9d-f6ec-0daa-a11d-c75589dcbe6c@nvidia.com>
 <20230413163216-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818B39801152ECBA138E73DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMKqzN3E9S-pusTr=doYRtDvTZUie2PrygzPiH0p5fvg@mail.gmail.com>
In-Reply-To:
 <CACGkMEtMKqzN3E9S-pusTr=doYRtDvTZUie2PrygzPiH0p5fvg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY8PR12MB7098:EE_
x-ms-office365-filtering-correlation-id: f12e7873-6c86-482f-ef07-08db3c9202dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 SFRfWbleTM8I5skiSc6QiD5cSkr0Bs1JtpQf3vD4uYKiJWt1VWaBlX2XFREtmyRXf5WrwtSoJhXf37wUqDEGkEFiksmAW9JA1IWhSO0pzB82x6xJ+F2zQFF52z9+M4Wvm8gZ8KDLdZDip/82TKNUlTXtUmSZaRRaT0GL/wXf1vakEoEyZ1g75xr5t8LfKimS5XQlNOxb2f24fjxU0ZoeJWnSDgP0dbnmch0kmYWcWMthbK47pBgR4sDqruuo8EYHn6MMgUt4F/sx0ShYpDyoIQyjwEVhAIztwq7r+4NtYzC06CErNLOZ0t0dgiFZAttZtIswQ6x53hz0CEQAJwDKtT2gJWjCsswz3M6qU0P9G3SizHvjuL7tl3XNRfjuQMRBRsUDHZzE5AJwxw+5ZlgUU2exGdUPbPvOxAyDQukmhvSwpGU9WLaZK+5qhB7cDkKgdLTPvn7BiiGQko5N0eHczw0MbV4Hck3j/buMS5V02YizwS2p6eGU4tHrqGjsIvuVBfBN9l5dEdC80KC4hmJwgwersHZH9/ZHJ0wxp0jf6G0NOANYyiWzARB/XccU91Kt5b0tmgFnpqScDjVIIu9iiMX/Po9dn3lCvKqcmsD2jTKea8SalpX1R7/gkcv6cK4M
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(451199021)(316002)(41300700001)(26005)(6506007)(122000001)(38070700005)(38100700002)(7696005)(9686003)(71200400001)(86362001)(6916009)(66556008)(66476007)(66446008)(64756008)(66946007)(4326008)(186003)(54906003)(55016003)(33656002)(76116006)(8676002)(8936002)(5660300002)(2906002)(4744005)(52536014)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Mk1MYUpPRnhpcDEvR1NZN0FQMEE4TmJzNHB2anBjUFp4SU1kbTZqajB0ZGhY?=
 =?utf-8?B?RE1DS3hqY2t0VjlvV3lwTzR0V01RblhpckZ6OU9LMmpKNTdnRmplMWZpQzRw?=
 =?utf-8?B?ZlhkT1ZSWUdaU1Z0WlllUTd6NmVVTlJ4VEpUakYvMVhIaVQ5VDhsRFRudy9V?=
 =?utf-8?B?aHFwMWk5U1BNbnd2K2t2M2g3ZWhRdkVnVkVsUFJRZngrSkVlMUU3TTFQNHlL?=
 =?utf-8?B?ZUQzM0Y5QnkvSU1xRkh0UjdFN2MwQVZza1lrQnI1TFNTWXpxa1RwRzhJRzZn?=
 =?utf-8?B?eWEyTmFKcy94bHJTNnBLMmI4UWE0Nk1Dd2d1cGVLREcxNzdVWk9vN1p5eEtT?=
 =?utf-8?B?NFJXbzRER3pLOEVoRFFISWc1MWtTNzdXcTlqb2VYcEJmcEY3Rm90enoyZmRh?=
 =?utf-8?B?R2x6RGpaQ09UN250WWUxaDFZR2hUZC9jbm51VmlvNStvTHN1UTl4Z3BFOVQ0?=
 =?utf-8?B?bGl5aE1ON0M2WU1xdVFzQnNrVkVhVXppd1ZlSExUN3c1Q3kvckc1bGc5ZFpV?=
 =?utf-8?B?Rk92SkVxMitBVUdxOVpUMEN2UTV4N0Vsd2poZXN0cnFHeGdqWmo2TlZrQndj?=
 =?utf-8?B?dW96RVIwc0czVjJUcWIvZlhWbEFXWEFwb0ZlU3ZrSmxzS0tScmYxZEtpbmtG?=
 =?utf-8?B?cjhxdSswaCtjYWVLYjRQaUZMcExYWW43WnhtR01iYS93bTBmY1VzeXlJZGI4?=
 =?utf-8?B?RFJZanRydW1LNW9UT2EydWsvdUowSVRzRGRGWjFDRVp3TmRtdHZJZlVROEp6?=
 =?utf-8?B?eFV3ZVBudHM1MXpmVXY2YUdjY0FYOTlUcm5XekFyNGdFcVBlbVVCSERqbHVP?=
 =?utf-8?B?bzdEeGExdlZYcDY4cHZ1YXJITHcxL2JUTlVBV0VxaEUyWm5QaVZsdE5MOE5X?=
 =?utf-8?B?aG82OWlHTUNSemV2UGVLVEtZdVo1Ui9udVZpK0pKcWdObll0cVdReEcyYkN1?=
 =?utf-8?B?Q24zS1JkSEt6VW5keGpITE9xZFdkNzk1UmVLTDlKWEFLZUt3WUFscXVTMk1j?=
 =?utf-8?B?c0FkZHZPTGpqcmVTN3pqYU9yYUVRUVVZWHQ5ZTg1UlhjR0F0NDdvK0pXS3dE?=
 =?utf-8?B?NGtIMlZXbTNEcjVleEUxMVZKN0NlWm1FYW05RXhrUCtNWGVyQWhvcm5DQWJU?=
 =?utf-8?B?R0cxRHhockw3NU5WdVkydHNJTi9lOHluY21XYkI2V1FjV0VlOGJ1LzJ3SERl?=
 =?utf-8?B?Ky9qSitwNTJtODdiQnBBSmcwNzM2ZlQ2Slp4bWtBdWpyUzV4UEtvUHg0cGpZ?=
 =?utf-8?B?b2VlUHFZcy9JbU9mM1FmN2grSG5yWjRjeEdtUmtISDZrbXpRbWsvK2RCR0li?=
 =?utf-8?B?aGp1TVZZZEsvTTJlV1ZiZVgvUWVUa0hFcnNXYzAxWnowdHlhODVCYkFwM2Nu?=
 =?utf-8?B?Rkd6THdJWmwyeVRVKzdJOXBqMnlRZFY5cmFoUjJRbE11bUxybXBpRXlZL3cy?=
 =?utf-8?B?K1ZaTTRnemZZTUlkM29tdjV0cUpGMkpOcVp0a1V6Y0dYbnpoRFZEcllpVkJY?=
 =?utf-8?B?R2hXaXVqZjh0dG9PY3g2Qi83dmNmc1lmeWpZZ010VlM5L3d5OWRVbzVtVXBp?=
 =?utf-8?B?T2VxblVTSVRLaE13cW1XMTFBbkwzNEQ5Rm9lYzYxK21hUkluQXBqTjRMbitH?=
 =?utf-8?B?VzIvYjlQOTYwNkNlQ1VVRGdFZnBpVWZnWXlneUxuZTBHTVZKb3VIK3pDRWlj?=
 =?utf-8?B?d0JWZXZ5R1VnODYrdmQ1UXk4RW14RDJiemF4cWs1UG1ycEpUQnJwTnBlZWNa?=
 =?utf-8?B?VG9xS2pvRG9iMTJqa0NZSlN2TGl6alRvL0lQYXBjSXIvdE9xNnk2MzBpb0ZZ?=
 =?utf-8?B?MlpjdWo1Tm12T1d4SncxcE5LRWdtL1ZmMnRPZDVBZTVZY2RLTUc0ZkFCSlNx?=
 =?utf-8?B?T3pUM0Y5aGhWQ2hqVWVxMU5QZndWQXh2VjArWklxblVWVnZveFc1UEJEVUth?=
 =?utf-8?B?TFVPU0dINnVHSll2V1Q0ZFF1eEFsN0lOeENLcXB6aGwxSFZWS2ducjV4Mk9U?=
 =?utf-8?B?cnVOQ0pjL29GeXBLSmtqYTl0bTNlV1RKV00wK0lmK0svNzlWZjV3L3lPc3Fp?=
 =?utf-8?B?c0JQWFdnNGFzTUUyT2hTbVVia2tnSVdwTDVvY2dVMWVmNk82Qnc5REE4R2RP?=
 =?utf-8?Q?hRAQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f12e7873-6c86-482f-ef07-08db3c9202dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 02:43:21.3731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9k2uwbhf/myUmwQE7WLGZw+FgMUTb7o2Bo6qplgoeWz3fzHyFobkbufGX2Wm3B2yEBubFVT17QcOoZ7V6X8hcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7098
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBBcHJpbCAxMywgMjAyMyAxMDozNyBQTQ0KDQo+IEknbSBub3Qgc3VyZSBJIGdldCB0aGlz
LiBXaXRoIFZJUlRJT19ORVRfRl9MRUdBQ1lfSEVBREVSLCB3ZSBkb24ndCBuZWVkDQo+IG1lZGlh
dGlvbiBmb3IgZGF0YXBhdGguIEZvciB0aGUgY29udHJvbCBwYXRoLCBtZWRpYXRpb24gaXMgYSBt
dXN0IGZvciBsZWdhY3kgYW5kDQo+IGl0J3MgdmVyeSBlYXN5IHRvIGtlZXAgaXQgd29yayBmb3Ig
bW9kZXJuLCB3aGF0J3Mgd3Jvbmcgd2l0aCB0aGF0Pw0KDQpUaGVyZSBpcyB2aXJ0aW8gUENJIFZG
Lg0KVGhlIHVzZXIgd2hvIGF0dGFjaGVzIHRoaXMgVkYgdG8gdGhlIFZNLCBpdCBkb2VzbuKAmXQg
a25vdyBpZiBpdHMgZ3Vlc3QgaXMgdG8gcnVuIGxlZ2FjeSBkcml2ZXIgb3IgMS54DQpIZW5jZSBo
eXBlcnZpc29yIGRvZXNu4oCZdCB3YW50IHRvIHJ1biBzcGVjaWFsIHN0YWNrIHdoZW4gZ3Vlc3Qg
bWF5IChsaWtlbHkpIGJlIDEueCBhbmQgZGV2aWNlIGFsc28gc3VwcG9ydHMgMS54Lg0KDQpUaGVy
ZWZvcmUsIE1NSU8gQkFSIDAgZW11bGF0aW9uIGlzIGJldHRlciBzb2x1dGlvbiBpbiB0aGlzIHVz
ZSBjYXNlIHdpdGhvdXQgYW55IG1lZGlhdGlvbi4NClRoZSBjdXJyZW50IHNwZWNpZmljYXRpb24g
Y2xhaW0gdGhhdCB0cmFuc2l0aW9uYWwgZGV2aWNlICJ3b3JrcyIsIGhlbmNlIGl0IGlzIGZpbmUg
dG8gZXh0ZW5kIEJBUjAgdG8gYmUgb2YgTU1JTyB0eXBlIGluc3RlYWQgb2YgSU8gdHlwZS4NCg0K
SW4gc29tZSBvdGhlciBjYXNlcyBjb250cm9sIHBhdGggb3IgYWRkaXRpb25hbCBvdGhlciBtZWRp
YXRpb24gY2FuIGJlIGRvbmUuDQo=

