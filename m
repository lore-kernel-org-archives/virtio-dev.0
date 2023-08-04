Return-Path: <virtio-dev-return-13466-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0982C04A94
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 06:56:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4A8BF45B2E
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 06:56:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 431089866ED
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 06:56:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 36B119843C5; Fri,  4 Aug 2023 06:56:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2195D9866DE;
	Fri,  4 Aug 2023 06:56:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEpbu++LujTPPzt7jeLfdwOnZvSLSATC9XzezfArr/SVf1W5xw69UU7TrlTRYxK1JVlOUWuhJAheXo8XE1YP6iaFaMRDfPjhj08Wh/39EgU/7uENsTTb59/M7GwxwtnXOuDbyQlbDqQTnjycmrhjUKvNBHoKeKr/AEdtIg/UGi8XXyqQoDAKkgg8dqzrEdvKdLOiIS+xIq3hDSdtgazZtqNv6ggX13+uCAxwytnjSek2QyuOc10OpCKEMh2dXi+OdyoZEUD8mfQPTPVK1JXP1Ji8ucAxZzzoa4ORv3S6QLZnnbCP47y2/2oLRibdfx2Id+m18lO9fC/fgWkYNtiR8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6H7yibplx/F5ByZMzD3vhbyNhNUK5PlvuYA2BS/hszg=;
 b=j0AlqDhzFEqNMm8NxDAVim9rjJ6ez/vOrtfXABmGuHEoM1hSmjg7D+WSEAXf1fd3O3zJEQvSZ06Wdz1coJLLbqep/cqYCQF2ibVpz3e+IMbIUDwtb24OOKRic2Jj4imFbLwtWaedcwJD3Snd5Y/OBD+y76gDbCtMqhix5IOcJaikBDEuWNGvMGW59Z/aC+qnjOsEZFUyvFq4C+OuZnnZm29CpHUIzuSPb7n5jkvwJKdRSwE/pLZi1cZflsH/ILj/KpCwfRuTYMmrlyGlN4e/wYFFAtebTKI+OEGFi2A53cmcKot9tqvvyNjhCBkzV6/8LdrehAMZq6wiuicg7iR5ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Robert Beckett <bob.beckett@collabora.com>, "Chen, Jiqian"
	<Jiqian.Chen@amd.com>, Gerd Hoffmann <kraxel@redhat.com>
CC: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Stefano
 Stabellini <sstabellini@kernel.org>, =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?=
	<roger.pau@citrix.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Koenig, Christian" <Christian.Koenig@amd.com>, "Hildebrand, Stewart"
	<Stewart.Hildebrand@amd.com>, Xenia Ragiadakou <burzalodowa@gmail.com>,
	"Huang, Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia"
	<Julia.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Thread-Topic: [VIRTIO GPU PATCH v3 0/1] Add new feature flag
 VIRTIO_GPU_F_FREEZE_S3
Thread-Index:
 AQHZxPBmx6oJ9gLSW0KyczkfJaHsia/WbxOwgAATkoCAABREwIABSzsAgADjSgCAAO2OgA==
Date: Fri, 4 Aug 2023 06:56:43 +0000
Message-ID:
 <PH0PR12MB5481D29B65853913101593E8DC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230720121844.8956-1-Jiqian.Chen@amd.com>
 <BL1PR12MB5849C19607B02CDA76BD9F61E70BA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481C2248C74E551B3318DD8DC0BA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB5849A2599DD46405262B8630E70BA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB54819BEBB889ACF23324B69EDC0BA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB5849EC8E7EE93D76AEB7030BE708A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <7afaefa6-2734-b3d9-d728-a06f5ad2df63@collabora.com>
In-Reply-To: <7afaefa6-2734-b3d9-d728-a06f5ad2df63@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN0PR12MB5740:EE_
x-ms-office365-filtering-correlation-id: 790d2752-d2f5-4690-b5fa-08db94b7f640
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iwoxU2Mht0XhpQpZbhi1qifIfQS+547U8o5Fz2h08UTu7MyvQYBwpADLNcNQWQmETzY0Mbv5Zae4EU8wtcNmyJE1dSHOXqqhchWGbYNGaHreOSekO4C7ZvwQqWz5VKLqjGWqUZ32/TBgz9OklwHpnWRNGQ4BJlLvd2IbSgtBL9rq/nKEdmgGUZAyAvykfQ40QDpc7gBOU70f0bb6mOE4dQU39adMcqquxpjWe9UMJVT3fmslBvrtz6K3chCCQXv0XZyrVWeqLISji6FzEET0NWuXm/FUWZhdUL0kGvnce1JDA2yiry/VwNqNLJG+ZD4X03ig2SsfJG+BQVoINwkwkathxoyCPf/QmJ6sPlsZlJf2xleNF6yBAQev8Q50IoZA+O8UPTqWC7/dksCvuZ8mwYqQTRJJn67EeH+L0hYWb97dgKHP0HvX8OhwpvCDrTiRW98CjBML/gJePA0kfndjYC4KNSzV+N28C0WptezRLbRPkKiz4uxTqLrkxetWPHwqzyxZF96ce6bvJNU4QSJiU3ms5KUXA5Xqmi2NDbGz9p7YL7QxjSeeB+wlZs/3oq1WyhLK8P4ix5lZANgu/cHk9Vp8jpw4sn7Wh+l8F4M5a0D/5+C10tDf+2k+BBTjVRpr
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(1800799003)(451199021)(186006)(8676002)(26005)(6506007)(83380400001)(66476007)(2906002)(316002)(76116006)(4326008)(66946007)(5660300002)(66446008)(64756008)(66556008)(8936002)(7416002)(41300700001)(7696005)(71200400001)(52536014)(9686003)(110136005)(478600001)(54906003)(55016003)(38100700002)(122000001)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WmdWTnJuMW42K2doRW0waHVIYjFmUjhHM2UzZWpZZkUwdVBta3poRkRVSFlT?=
 =?utf-8?B?SG5TMmdtTE5ITVhuekcvb3Q0OWlDQ3M0YnN1SWorbGhVakt0aXFGbXRIRGFt?=
 =?utf-8?B?cjJIQVN4Vm1jcU5rSWlkd0N5RElmZ3ZldEV1K3FuNkU1VWF1WFdPL2xRbXdG?=
 =?utf-8?B?eUduUDVsS0lIMkdIWTREWFcwY2oyalBqTzU5RFlUZmZGSitrS2Q5ZWp2TXFl?=
 =?utf-8?B?M3NQNThzbS9jRVdPR21xSGlybWJQNnIrUzVCTU1WNGRMd1ZmbW4vdUJvVDJS?=
 =?utf-8?B?cW1lTzFFWUwrRFd0THBHd2l3c1FaWUpLYUhQcnNwVWd6TXdnRCtIOVA0TnZI?=
 =?utf-8?B?bmgwaSt1NW51V2FyTVdUVW1KUkd2SzNGdC9lQ3lYN2lRNzVVdXUwcXRLQjRm?=
 =?utf-8?B?WGNWNThYaHBqMHZhRHVDMk9MUkhNV2pzelhETENMOTd5WFZuOVZiUnpiS1hM?=
 =?utf-8?B?K3RkVEh5RExDdENXaUdTaGcrYXEvTzMxTnRJS3l1V0ovc3dmbVgzMi9qdFRj?=
 =?utf-8?B?YkZkcXQyVkxJSnc1YXA3MnVTV0ljRk85T3E2cCtsSnRMRWh0NUxod3lQT1ZD?=
 =?utf-8?B?eGRYOUtjdVdVWG93TjlGQTJwbEVZY1U0eFVueEJxZ1E2cUk1bGQxb0hhaHRq?=
 =?utf-8?B?ZVBFVVJMS0ZrbkRLdTYrUCs2d0NVaTBQMEZ1U2liTUdvbGxXY05udmlkYXRu?=
 =?utf-8?B?NXpLdG1PRVZGUFhHU1U5VThKbVZiNXVuYTNib1pDTHJZc0JpUllCZmhJSU4r?=
 =?utf-8?B?dXZiODRmaGZvODZVeGVRdHR6dEcrTStTb1dvbG1iclJWUXpCa0NsWVVCMlJt?=
 =?utf-8?B?YTdSOWo4NnVNbTA0dVdtMWVlcWkyTWNDcTJqVVl1ZC92N1FpUTQvRVdBL1di?=
 =?utf-8?B?c3F3TDZTbzVERG1mYTk5M0VldUxNY1JFTXg0TWJ1aVFnSkFtRytSeGsrZ0Fj?=
 =?utf-8?B?UkZTMkZXdi96KzBTYjA2ZTF0TGl4MGpzQUdBUXE1Rk9rRUFEZW81cWRaZG9m?=
 =?utf-8?B?TU93UEYwUUxjcUZab0dWNEZObFJZdE5YNDdDWmdJajRENzZZa0Npc0VFY3Fy?=
 =?utf-8?B?YTZtUUk3NEdjN0c0QkgwSjE4c3NROUJQOHN2cTVmMmYwOFBjMnh1bzdIcFZ1?=
 =?utf-8?B?a0FjZXRoUHZBT0N6b2hJYlNibysvbGFmU2tUbjc5T3Q2VDJsSUExNG56TFVq?=
 =?utf-8?B?UktOdy9uWmZZMGNBYmRDT2x3bmF3WG56TkVpRDE0SkNFMXFRZ3k3Wi9RcVdp?=
 =?utf-8?B?WmVoRkttNyt2SnZXM282aXUvK2NzTm4vNVAvOTJVVmpvcURHWkw1QkNyODJF?=
 =?utf-8?B?bzdLUzVrbHdpdFhSNzJUUE5FeVJvSnN3N2ZDMUlPMHJEU1JwMjQzK0VMdTMy?=
 =?utf-8?B?YUZCL0RBVXZqbGMzTTFYTFI0bTREVS8zdHhRTkVkcThXeFgrSEMzVnIva00y?=
 =?utf-8?B?alpaOXJTNGhYNUR0aVNoNWh2SDBVYWJ5UE5ySzhTR0lBekpBdFNZZVRVeEwy?=
 =?utf-8?B?eUV1OGZ4SlNJcEM2R0E3cElPZklsR0crK0FYL1RTTkFlRFpkUnU2eWxLVlZt?=
 =?utf-8?B?cjRRZnBUZnp2bGE0dHRWVUJ1N28xMGZIZTluR1pJakRPcGF1VWRKeWdTZnJI?=
 =?utf-8?B?bHNkb0lvYlltN0NkNk9ld1dmbkpmbUpuUDkvZSs2eEYrQ0RZQkl4UWR3MVJM?=
 =?utf-8?B?bEl4TW9tNHlvUDlXWkRkcUptVXhrS2VNTHJ6bmczUlozd2cyUTRHZE1WVlcy?=
 =?utf-8?B?SFM1d2FGTG5od08vM09RcGFDOVc3bUpzM2ZkdzNIMnBHMkQ4TVhxVzNoOFh6?=
 =?utf-8?B?KzZIeEM3aWduWWh1QTFuN0dQZzBLd1lNbDA3c3BuN3QxeWY1Z3ZmT3BYeUh5?=
 =?utf-8?B?WTlSbmwydFBKdXAxc2dlNHN3NU1mdUlXa2gyTHhZaVAwYm5sTVlzUi9ZcUNh?=
 =?utf-8?B?ekZEeXJUbTRiZFpha3VSUllNdVFjc01oWmpOc2dhUWpOVG9RVGYrT0doV0cw?=
 =?utf-8?B?MFNVWTBudXRMc2dvV3dmcnhiTGRYeXZ2c1luWGtrZWpiaXg2RzduYjVZVFNh?=
 =?utf-8?B?Zktsbzk2WjZwOWR1ckxqNGJDdHYxaElUK0QyWFp2UFZUOVJ6QXJRQVFhR1ZV?=
 =?utf-8?Q?Kbhg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790d2752-d2f5-4690-b5fa-08db94b7f640
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 06:56:43.4022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j3898ElLEY6mzwRFbveFv7iEs8YX/M/DG9CUm6EG7IAF/W93GSnzMA8Gk7TdqozPwQWNth7hSXfmWOVB6zS3Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740
Subject: [virtio-dev] RE: [VIRTIO GPU PATCH v3 0/1] Add new feature flag
 VIRTIO_GPU_F_FREEZE_S3

DQoNCj4gRnJvbTogUm9iZXJ0IEJlY2tldHQgPGJvYi5iZWNrZXR0QGNvbGxhYm9yYS5jb20+DQo+
IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMywgMjAyMyA5OjU5IFBNDQoNClsuLl0NCg0KPiA+IEkg
dGhpbmsgdGhlcmUgaXMgbm8gbmVlZCB0byBpbXByb3ZlIHRvIHBjaSBsZXZlbC4gQmVjYXVzZSB0
aGlzIGZlYXR1cmUNCj4gPiBpcyBhIGNvbXByb21pc2Ugc29sdXRpb24sIGlmIHJlc291cmNlcyBh
cmUgZGVzdHJveWVkIG9uIHFlbXUgc2lkZSwNCj4gPiBndWVzdCBoYXMgbm90IGVub3VnaCBkYXRh
IHRvIHJlLWNyZWF0ZSB0aGVtLCBzbyB3ZSBjaG9vc2UgdG8ga2VlcCB0aGVtDQo+IHdoZW4gc3Vz
cGVuc2lvbi4gVGhhdCBpcyBhIHZpcnRpby1ncHUgc3BlY2lmaWMgc2NlbmFyaW8uDQo+ID4NCj4g
PiBXaGF0J3MgeW91ciBvcGluaW9uLCBHZXJkIEhvZmZtYW5uLCBhbmQgUm9iZXJ0IEJlY2tldHQ/
IEFtIEkgcmlnaHQ/DQo+IA0KPiBJIHRoaW5rIFBhcmF2IGFza3MgYSBnb29kIHF1ZXN0aW9uLg0K
PiANCj4gV2hpbGUgdGhlIGluaXRpYWwgcmF0aW9uYWxlIGZvciBkb2luZyB0aGlzIHdvcmsgaXMg
dmlydGlvLWdwdSBzcGVjaWZpYywgdGhlIHBvdGVudGlhbA0KPiBpbXBsZW1lbnRhdGlvbiBvZiBh
IHNvbHV0aW9uIG5lZWQgbm90IHJlbWFpbiBncHUgc3BlY2lmaWMuDQo+IElmIHdlIHdhbnQgdG8g
Z2VuZXJpY2lzZSB0aGUgc29sdXRpb24sIHRoZW4gdGhlbiBxdWVzdGlvbiBiZWNvbWVzIGF0IHdo
YXQgbGV2ZWwNCj4gc2hvdWxkIGl0IGJlIGRvbmU/DQo+IA0KPiBSZWFkaW5nIHNlY3Rpb24gNC4x
LjQuMyBvZiB0aGUgdjEuMiBzcGVjLCBpdCBsb29rcyBsaWtlIHdyaXRpbmcgMCB0byBkZXZpY2Vf
c3RhdHVzDQo+IGFzIGV4cG9zZWQgdmlhIGFuIE1NSU8gQkFSIGlzIHRoZSBQQ0kgdHJhbnNwb3J0
IHJlc2V0IG1ldGhvZC4NCj4gV2UgY291bGQgYWRkIGEgbmV3IGRldmljZV9zdGF0dXMgdmFsdWUu
DQo+IGRldmljZV9zdGF0dXMgc2hvdWxkIGJlIGV4cG9zZWQgaW4gYWxsIHRyYW5zcG9ydCBtZXRo
b2RzLCBzbyB3ZSBjb3VsZCB1cGRhdGUNCj4gdGhlIHNwZWMgc2VjdGlvbiAyLjEgdG8gc2F5DQo+
IA0KPiANCj4gRFJJVkVSX1NVU1BFTkQgKDUpDQo+IA0KPiBPciBzb21ldGhpbmcgc2ltaWxhci4N
Cj4gDQo+IEFsdGVybmF0aXZlbHkgYSBuZXcgZHJpdmVyX3BhcmFtIHJlZ2lzdGVyIGNvdWxkIGJl
IGV4cG9zZWQgdGhhdCBjb3VsZCBpbmRpY2F0ZQ0KPiBzdXNwZW5kIChhbmQgYW55IGZ1dHVyZSBv
dGhlciBwYXJhbWV0ZXJzIHRvIHN0YXR1cyBjaGFuZ2VzKS4NCj4gDQo+IA0KPiBJIGd1ZXNzIGl0
IGRlcGVuZHMgaG93IHNpZ25pZmljYW50IGEgY2hhbmdlIHdlIHdhbnQgdG8gdXNlIHRvIHN1cHBv
cnQNCj4gdGhpcyBhbmQgaG93IHVzZWZ1bCB0aGUgYXJlIHByZWRpY3RlZCB0byBiZSBpbiBmdXR1
cmUuDQo+IEFyZSBvdGhlciBwZW9wbGUgYXdhcmUgb2YgYW55IG90aGVyIGRlc2lyZWQgcGFyYW1l
dGVyaXNhdGlvbiBvZg0KPiBkZXZpY2Vfc3RhdHVzIHVwZGF0ZXM/DQo+DQpTb21lIG9mIHRoZSBz
dGF0ZWxlc3MgZGV2aWNlcyBtYXkgYmUganVzdCBmaW5lIHRvIGRlc3Ryb3kgYW5kIHJlY3JlYXRl
IHRoZSByZXNvdXJjZXMgaW4gdGhlIFBDSSdzIGRyaXZlcidzIGNhbGxiYWNrIG9mIHN1c3BlbmQo
KSBhbmQgcmVzdW1lKCkuDQoNCkFuZCBEUklWRVJfU1VTUEVORCBtYXkgbm90IGJlIGV2ZW4gbmVl
ZGVkLg0KDQpTb21lIHN0YXRlZnVsIGRldmljZSBtYXkgbmVlZCB0byByZXN1bWUgZnJvbSB0aGUg
c2FtZSBwbGFjZSB3aGVyZSBpdCBsZWZ0IG9mZi4NCkkgZG8gbm90IGtub3cgYWJvdXQgZ3B1IGVu
b3VnaC4uDQoNCk15IHF1ZXN0aW9uIGlzOiBpbiB0aGUgdmlydGlvIGdwdSBkcml2ZXIsIGNhbiB5
b3UgdXNlIFBDSSdzIHN1c3BlbmQoKSBhbmQgcmVzdW1lKCkgY2FsbGJhY2tzIHRvIGRlc3Ryb3kg
YW5kIHJlY3JlYXRlIHRoZSBuZWVkZWQgcmVzb3VyY2VzPw0KVGhpcyB3YXksIGd1ZXN0IGRyaXZl
ciBoYW5kbGVzIHdoYXQgaXQgbmVlZHMgdG8sIGZsb3cgaXMgYWxzbyBzeW1tZXRyaWMuDQpGcm9t
IFFFTVUgcG9pbnQgb2YgdmlldywgaXRzIGRyaXZlciByZWluaXRpYWxpemluZywgc28gUUVNVSBz
aG91bGQgYmUganVzdCBmaW5lLiAobm90IGp1c3QgZGVzdHJveSB0aGluZ3MpDQpXaHkgd291bGRu
4oCZdCBpdCB3b3JrPyBXaWxsIGl0IGJlIHNsb3cgb3I/DQpIYXZlIHlvdSBleHBsb3JlZCB0aGlz
IHJvdXRlPw0KDQpGb3IgZXhhbXBsZSwgcmFkZW9uMzAwIGdwdSBzZWVtcyB0byByZXNldCB0aGUg
ZGV2aWNlIGR1cmluZyByZXN1bWluZyBhbmQgc2VlbXMgdG8gYmUgZmluZSB3aXRob3V0IHBlcnNp
c3RpbmcuDQo=

