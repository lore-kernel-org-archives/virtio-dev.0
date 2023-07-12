Return-Path: <virtio-dev-return-13356-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABAAEB64DA
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 16:52:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AE2DD1922E8
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 16:52:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A03F99867B7
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 16:52:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9111B986682; Wed, 12 Jul 2023 16:52:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 73FD6986686;
	Wed, 12 Jul 2023 16:52:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CytjohHHu0C/k1HjpHL8jjF7H05QWyxHMlkaZDbnOojCzrc6eHtz/KRxHh2Qr/+qUuhL3hirdD0L/WiyiuA+D5KHYe2GWkFoOhdgJknBJwKmLiUIKx+SwORC/HJ41WQwOw5OpuF1/xgJ7trtsAyXx4iUTL0lS61Ic3b1P7yfuKun8IPKCX50HucFSeWc795Xq346NvfNshbE408pMfyMd7edZ7EqjdLSxBgLGGs2AUySRC4Q+9fAlu+oLfc443Q8fqkT5iAxCezc4yhRx6pQAVBhooAEm6psxnUSMRXj6L1T4dgbMwV/a2JIDgmz284bOtQaZlavxqqw0LacQVlRrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkaWvVPc5JAvLJ1w3HZsBuf+c2KYllVJ0Qeebm+AaDk=;
 b=oBlcHLTLDQEtLaXtXE5vIfRTTP/RpgTcfNrBH53X855HnATETI4ndhHDx475Yjg3BbHaLtoIzemcAazokcIscRTtALK+O+/xfx8xNNSovr/u8GhSTPxPzKNGr3HpUL6ggoyV1rXMP7sNZU22hWPLqPT9R32dFncJhw0vJ2KFCjNWgjr8GqcoDqxiWtZmdTDTiX9I6z762Erd416CodTMiz4qSfLLAZ0Rxt2VpADm7po3TRFkaa/w9p+rwu7srJXO9WgILXbFwcQILwcqbLibPh6dIPHzKueYXsOX0tGWjgwD5BTF4KmgTfjyaLkknpmv/0gLyNIBKa27wwubupta8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re:
 [PATCH v21] virtio-net: support inner header hash
Thread-Index:
 AQHZrcLbGn+M0MXS/UagA7zKbS/v/q+2G4MAgAAA34CAAASegIAABOgAgAAHJwCAABjfgIAACBiAgAAYzSA=
Date: Wed, 12 Jul 2023 16:52:16 +0000
Message-ID:
 <PH0PR12MB548162D04BDB6E3AAD9F05B8DC36A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230703152711.106008-1-hengqi@linux.alibaba.com>
 <87pm4xjp4t.fsf@redhat.com> <20230712082508-mutt-send-email-mst@kernel.org>
 <87jzv5jo82.fsf@redhat.com>
 <e0e2b21d-a7f9-fbf1-7d93-d142c7a7618a@linux.alibaba.com>
 <87h6q9jm85.fsf@redhat.com>
 <b1b03bfa-45ac-42b8-86d9-aaf47c4704e3@linux.alibaba.com>
 <87edldjgri.fsf@redhat.com>
In-Reply-To: <87edldjgri.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA0PR12MB7626:EE_
x-ms-office365-filtering-correlation-id: a8a11e96-4e9a-4526-5fea-08db82f859a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GXU04UMBTc0+YHd3gw65ajiaz2/wr0AVHC3+oR7EXAmwLQ3Oq6EfPQhbDSWp92h9zs+JD1vu6ItiVTOgTE+YERNneggWt+IwHWWtomotS98wTogl7lxCkky2SBpYcxepy3WPTtc42HmR5PD9zArtAiE2yXueSGAWjvWBuYjS1ccpsZv4g2Z7hh8UFtWzV2UrmJxdxu+D7aNytM9MqbXTbl4YWtuuJXFGubfQD3szRoPO/tgKnYLw5qULx7FdCnOKcYp9vZhmp996dorrLTnTRiCmM5/v6n6kcC7TYoUDA+YPoRXkZLwTfBMh36bF1/2xgkeB3wKpnvsJ544U4M6QH2Ig+1572grMsTZhRyMDnyqZkMNYZke/ReuucjbsYZAfWs+pFcI2kk6KavBCg7kL5im2G2e+IhxhdfZN33JinHD+ZSSYB3d3YsrVWJ8RWuWS1jYQMEfVp+nMe5Yto24D96mtL9dBxXCCmQpLV/PQP+q1eiB11dzuXNyI7/2Gwt8ilzaoB4WfXoFsDbPDLJgCf1DCfI4L3FgE+SDIKptGvpb52GELvYiQw3kA03G/WGFM7EA1QfSmUKigcidFHP6PCWppRuAjM828oklH8S49KbE73z8AzHUipHKU6GqMiDzj
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199021)(4326008)(66556008)(66446008)(64756008)(76116006)(66946007)(66476007)(38100700002)(122000001)(86362001)(186003)(26005)(38070700005)(6506007)(9686003)(33656002)(478600001)(110136005)(7696005)(55016003)(54906003)(41300700001)(8936002)(8676002)(71200400001)(316002)(52536014)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z0JMRjVoSGdkTlYzTm1pWEFHSlNyTVRJTlpwaEdsTE5NYjZrZUtsTkhlenFx?=
 =?utf-8?B?bWQ2Z0xZSFgrWGZhWGU0UEpFNDFJZ0tiZkR3VmdZVEZTRzMxUXBRVENIcHpm?=
 =?utf-8?B?RXJnNW84ekNDc3ZxN05senB2U3REdDRlL045TnhBQ0svc28yUW12M1k1OUFJ?=
 =?utf-8?B?TkpPMTdxOHNucEI0d1VQVDJtb1NpdkF6Z0RkcjVna1lzTVd1Y2gzM2Z4VUZ2?=
 =?utf-8?B?emp1TjdDdnc2ei9pUC9BZzBjdTNzblF3cmNjNUlrWHBHYXVlQ1hHYzczOHp3?=
 =?utf-8?B?Q0o1b29HaEVpZHNvcjNMcS9rcmN6ZC9nNktqMmRGZnRrdnJxcUdDUlFLUVhL?=
 =?utf-8?B?aTIxQmtrV0twK0ZnUWluQTB6ckdSdWlUc3IxUFMzN1hkVFJpcCt0L2w1V0ZP?=
 =?utf-8?B?a0tlc1FIS0hzZjR5NnBLajJlbmZVODM0NXh3NERlNGI1U2t5MGMrL2dadlZa?=
 =?utf-8?B?Z2FnMDdIcGlNRWFjRWdlL2theUZuT3JwQ2h5UU9EalE0eGczeUF1dGRSVEJS?=
 =?utf-8?B?QWF6aHdNTGJISzZtbHQvZG5uNmI2SVBrMjJscnJ2WjZCelMwSnNLYWphZFc3?=
 =?utf-8?B?VFo0TjV2RjBlNDVsOWtxcEJ2ZUdmTURyVlh1RzluR1puRHhEMUVMSUtJT2c1?=
 =?utf-8?B?SURQRXdxaEltbXgzU0VFUEdUN0ZsVWhldVkzYW92Y2VPMGF6ZjBBTDcvMTRx?=
 =?utf-8?B?ZGxiL2g2U081cW15THRtY1NtNXEwb1BQMGJxcHZzT0pTNmloTnkramd2Y2VS?=
 =?utf-8?B?cU1RdjVKYm9YVkZBZ01xb3NHSzNjc2x2dDJwUVNIMUREVGhEb2V3aUtsYTh6?=
 =?utf-8?B?TXNxZTFpUVYyS2J4YWNVUGpvZkN4NjNZekhlNkRXY3drNVdnMUU0VDBoTXp2?=
 =?utf-8?B?MHNJRjJzWEN6Ui9FYnJ6WVY2M2lKNnVOUjcrRVVQVEN4dDA1MGFsaGJjR2c1?=
 =?utf-8?B?NkpXcGgzMVdpVFVuRy84TkpnUlFRTzBZeHVLZDRCNHFaQWNkL3YyUHU4K3VB?=
 =?utf-8?B?dXVzNjhNQnoxdVdjQllXb1BDWm1DWWRFYWMwTTJUS1BZUTA4TW9TSDlnWExD?=
 =?utf-8?B?b1h0OVpLVTdra05FbE12SER3VjcwQ3plTVdXdmkweS9MY1VubVVITGpvOEhV?=
 =?utf-8?B?a0ZsVmg1czN2cEUwSGdrT3haN3ptVE5QTlhQcVdjMmJNZlV4OVJRbWV2ZEtM?=
 =?utf-8?B?WnlZYjdYV3FQbEVDdVRjUnVjZUZZOHA4M2VLanU5OURNcWMxNXF5clAyQ0JQ?=
 =?utf-8?B?em82azZnK3JYWkNNTGRYUkVpR0VTYWdtclRlSzhvZTNNRVV0Z01QOUJ1SGpw?=
 =?utf-8?B?eUhSb1lpYmhldVBKSTlsTldleFpNenZkZ3VYem1lRXMwVHV6Zm45K295Vllr?=
 =?utf-8?B?WjNQSWJTMG1PU0ZGQ1ZwYUtpN0xSWERaNHYrcW5rY29WUFpNVmZqVjYySEE2?=
 =?utf-8?B?YUQrdUpmZWVsczRCcWJnbFdIWFh0OGdvaVhLSnlMRUVHcVU3cm9pakVWUmNz?=
 =?utf-8?B?RVB1THFIWTdzdHBjaWFmNC8ydUJPWk04YjhteUNZRlA5TGs4Tmc0V0ZTWXhN?=
 =?utf-8?B?dEtLZVNZYnEzMGVEbE1EU1ZMWFFaT2Mrc2liQks5VnVUS213d2F1VXNCbW9E?=
 =?utf-8?B?OFlJZ1ZtcHBsQnFveFpNK2NJeVBrREVXM0ZkVHpZK3ZHVVRlaEdZeTZuOTM5?=
 =?utf-8?B?ZlRpejhPN25OY2JtblhkYWhvd2lqRFBsSTFEamIyTndtRVVEK3Q2Ykp1SmVo?=
 =?utf-8?B?WEQxdG1UdVBvOTFpZW84QkpRWjFaTFBrai9BcWFmWHZyRHZrVlFhTmYrVmFC?=
 =?utf-8?B?MnVoQkRFd3pHMlRGZjVpRHNXOVVmLy80ei9uVXptOXpMODZXMVNtZmw0Y2Nm?=
 =?utf-8?B?b0Y2T0FESlJiM0VReFhzb2Vqek1sczFrMUdPTjl4bXF0ZU4zYy9LZW1sWDFm?=
 =?utf-8?B?VFZVWUd6OFlKbXIyZTg4ZmpEMVdJKytucjZ6eFpEQVdrRFNPQlpGYldvTmcz?=
 =?utf-8?B?a29DWGk5LzNvVWJxOGFpSUU1TEgxUGI4N1lEWTJiOTZPRU0zakN2eS9rQWtz?=
 =?utf-8?B?ZiszT0dJRUhJa2VjckRVQ2NvOTRqVEttd2M0L2lvaDQyNGgyY0dVcVBkMkdp?=
 =?utf-8?Q?X5Lo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a11e96-4e9a-4526-5fea-08db82f859a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 16:52:17.0294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VZYi+cfOF+aS3WM3eSVPoFvRlxoSEal6JJw0N6XiGra9vkaioHeoxN9bAdpBr40+B9IVJbEnx5c5oPy8/9O1sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7626
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH
 v21] virtio-net: support inner header hash

DQoNCj4gRnJvbTogQ29ybmVsaWEgSHVjayA8Y29odWNrQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdl
ZG5lc2RheSwgSnVseSAxMiwgMjAyMyAxMToyMyBBTQ0KPiANCj4gT24gV2VkLCBKdWwgMTIgMjAy
MywgSGVuZyBRaSA8aGVuZ3FpQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToNCj4gDQo+ID4g5Zyo
IDIwMjMvNy8xMiDkuIvljYg5OjI1LCBDb3JuZWxpYSBIdWNrIOWGmemBkzoNCj4gPj4gLi4ud2hp
bGUgdGhlIGNoYW5nZXMgYWJvdmUgZ2l2ZSBtZSBhIGZpbmUgcGRmLCB0aGUgaHRtbCBnZW5lcmF0
ZWQgaXMNCj4gPj4gYnJva2VuLiBUaGUgcHJvYmxlbSBzZWVtcyB0byBvcmlnaW5hdGUgaW4gdGhl
IG5vcm1hdGl2ZSByZWZlcmVuY2VzDQo+ID4+IHRoYXQgYXJlIGFkZGVkIGluIGludHJvZHVjdGlv
bi50ZXgsIGJ1dCBJIGRvbid0IHNlZSB3aGVyZSBpdCBnb2VzIGFzdHJheS4NCj4gPj4NCj4gPj4g
WzQwMV0gWzQwMl0gWzQwM10gWzQwNF0gKC4vdmlydGlvLXYxLjItY3MwMS5hdXggISBNaXNzaW5n
IFxlbmRjc25hbWUNCj4gPj4gaW5zZXJ0ZWQuDQo+ID4+IDx0byBiZSByZWFkIGFnYWluPg0KPiA+
PiAgICAgICAgICAgICAgICAgICAgIFx1bmhib3gNCj4gPj4gbC40OSAuLi5jdGlvbn1Ob3JtYXRp
dmUgUmVmZXJlbmNlc319e3NlY3Rpb24uMX17fX0NCj4gPj4NCj4gPj4gPw0KPiA+PiAhIEVtZXJn
ZW5jeSBzdG9wLg0KPiA+PiA8dG8gYmUgcmVhZCBhZ2Fpbj4NCj4gPj4gICAgICAgICAgICAgICAg
ICAgICBcdW5oYm94DQo+ID4+IGwuNDkgLi4uY3Rpb259Tm9ybWF0aXZlIFJlZmVyZW5jZXN9fXtz
ZWN0aW9uLjF9e319DQo+ID4+DQo+ID4+IChtYWtlaHRtbC5zaCBvbiBtYXN0ZXIgc2VlbXMgdG8g
d29yayBvaywgc28gaXQncyBzb21ldGhpbmcgaW4gdGhpcw0KPiA+PiBwYXRjaC4uLikNCj4gPj4N
Cj4gPj4gRG9lcyBhbnlvbmUgZWxzZSBtYW5hZ2UgdG8gc3BvdCB0aGUgcHJvYmxlbT8NCj4gPg0K
PiA+IFRoZSBwcm9ibGVtIGlzIHRoYXQgdW5kZXJsaW5lIGNhbm5vdCBiZSBhZGRlZCBkaXJlY3Rs
eSBpbiBcdGV4dGJmLCB3ZQ0KPiA+IG5lZWQgYSBsaXR0bGUgbW9kaWZpY2F0aW9uOg0KPiA+DQo+
ID4gXHRleHRiZntbR1JFX3JmYzI3ODRdfSAtLT4gXHRleHRiZntbR1JFXF9yZmMyNzg0XX0NCj4g
PiBcdGV4dGJme1tHUkVfcmZjMjg5MF19IC0tPiBcdGV4dGJme1tHUkVcX3JmYzI4OTBdfQ0KPiA+
IFx0ZXh0YmZ7W0dSRV9yZmM3Njc2XX0gLS0+IFx0ZXh0YmZ7W0dSRVxfcmZjNzY3Nl19DQo+ID4N
Cj4gPiBBZnRlciB0aGlzIG1vZGlmaWNhdGlvbiwgSSBjYW4gc3VjY2Vzc2Z1bGx5IGNvbXBpbGUg
cGRmIG9uIG92ZXJsZWFmLA0KPiA+IHBsZWFzZSB0cnkgdGhpcy4NCj4gDQo+IEknbSBhZnJhaWQg
dGhhdCdzIG5vdCB0aGUgcHJvYmxlbSAoSSBoYWQgdHJpZWQgdGhpcyBhbmQgc2ltaWxhciBjaGFu
Z2VzIHdpdGhvdXQNCj4gc3VjY2Vzcyk7IHRoZSBwZGYgZ2VuZXJhdGlvbiBpcyBhbHJlYWR5IGZp
bmUsIGJ1dCBodG1sIHN0aWxsIGZhaWxzIHdpdGggdGhpcyBjaGFuZ2UNCj4gKG9yIHNpbWlsYXIp
Lg0KPiANCj4gW1RyeWluZyBvbiBhIHN0YW5kYXJkIEZlZG9yYSAzNyB3aXRoIGEgZnVsbCB0ZXhs
aXZlIGluc3RhbGwuLi5dDQoNCkkgd2lsbCB0cnkgaW4gMiBob3Vycy4NCg==

