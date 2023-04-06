Return-Path: <virtio-dev-return-12047-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FE7C76196
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 14:05:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A1F8A1EDFF
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 14:05:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 90F309865E9
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Apr 2023 14:05:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 837239865D9; Thu,  6 Apr 2023 14:05:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 650A99865C1;
	Thu,  6 Apr 2023 14:05:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwq5r+WADhlQKrrIFKgtIv96JvMpUlcZRf/tEaNofrizQfnj+XIfTxeDiOmMwG/zYERpeM/xRg5LD3fWjEBO14evBJi2HSv7ITv/QANxIAiUDEYe9+C6jcwLBfvrreVaCbKgGPyioLsR72/i9rPTQsLkJ4ZNUAvKT80m4QvJLQgZEfk7FpYsCTAFQCe8sKWh2pVdy4/+LLOUJDrW304ghrfrR8ckU7U2DBVFI575dmBe15W4GiZcfQjS4nq2oZZ5lfBFYxm5Do+CtibY/xNAKXGh6IQC2z5ZJgvoR5BPJyISS1e3QvE8efIVofw9ngcFFGQVOw9eNzMTYbg3ILJDaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pea7hxlMy04Pi0Q4P1bgzz9f4PfpnLs+Dbbtlq/nVdQ=;
 b=BRoMku7t6LL03cNTmLioK3/cTp82Lhd4rsCN+BptAxfvypdYs7dvhqpKjvpmI4o9kpvfnuEgh3ZsJ8dlhA66cX3MYVBC/II7oInhzcCGZMq/w3bstj/w1OLQyocY6JlXbGxeWf1BapQEoEEmp3whBmTs/TYI/ft6kqo6lVwL9Yl8IEUET7q/NqVOLBKSBSxDkmEtDr9SB2iNmcf52gbyWD2gBcHcniaMVVFjCDpEENZx9V2Ifbr/dpQh7514lgDRT1nG7xroGsPnHizdbm1B55Q2QuJsDfOSPVgEOF2Jv/DTsAvEp5rrFX+FTccyQuNSKAm48gQvA+l8ATUsb8HZtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Zhu Lingshan <lingshan.zhu@linux.intel.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com"
	<hang.yuan@intel.com>
CC: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Jiri Pirko
	<jiri@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler
	<shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [virtio-dev] [PATCH v11 08/10] admin: command list discovery
Thread-Index: AQHZZj2F3Aowx06/MkKslNRQrzYnrq8d4+2AgABwDsA=
Date: Thu, 6 Apr 2023 14:05:07 +0000
Message-ID:
 <PH0PR12MB548174BC1333E7107B731108DC919@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1680533760.git.mst@redhat.com>
 <84cf421ad95111b37cddb52b2a7bf625b7955ae6.1680533760.git.mst@redhat.com>
 <0149d88a-196b-0bdc-32b4-1e01eb562310@linux.intel.com>
In-Reply-To: <0149d88a-196b-0bdc-32b4-1e01eb562310@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA0PR12MB8908:EE_
x-ms-office365-filtering-correlation-id: d3ef84c8-71f8-4bf2-2611-08db36a7ed9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 X6s1MEk5yEWwBaBIZnnSWjxCl63GN9gDD+NgJXOFOmCuhBQDbpcILr6uvK3bRxvs4X41vxIL5d4fJBXeDxXx0t5/vI7CreSlmB/oFCuGtbQkweC5fFjH7XcLo/5NCRPvBvo8OU/PUeoCIrLLTr5rtP7ERFFPbCXnMocov8qXz5bWsxRxJDXJVo5ycTSr502pDHNmhg/wdVwcOyShWHA4Nv75CLQm0t3uPT6x6ZU4C8I0xPTsE+XMrP8bFKmPhR0k5rroFC64XVkqL6CXqE6TpkHD46iJ7TrgVCc8InGPQuld1pStRvX0YFZRIuloQFwSZWuuTi1rEonr8UPiidgyJvmUHG2eeLfamhN2GboO+CVCqy9DZf10SaH8sIEmLZAH6hg0bua71jEbX1nwKeqk2g2/61nD1nWvkC/ok7zbP7pJF1qj4PMQDV0w7L4m36qZwtfFaTisP0cMqtDozlQ/RQ2adniyfRaRWH8UXbtU8K9gp3HCytq8O061oshrYX8fuQ/xgO8CDgmJQ1R9MsA2mIkCMVJgwyZ5w2iNNTpKaWZh91MXqOeZXwbEBid8s0X/QpQF9mpcS4QQ0BJkBO0H0xVpxegIzN8piaMVG8Gkyiej9A/l0Oy2lD+zNelwO9H8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199021)(71200400001)(478600001)(316002)(7696005)(6506007)(26005)(54906003)(107886003)(186003)(9686003)(110136005)(7416002)(2906002)(4744005)(4326008)(5660300002)(33656002)(38100700002)(64756008)(76116006)(66476007)(66446008)(122000001)(921005)(8676002)(66946007)(41300700001)(66556008)(86362001)(52536014)(38070700005)(8936002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZHQ0ejQxeXovTitqdlJLUjBtN2ZGWVFWVndjTitlbzZKTk9pOVliZW00S29U?=
 =?utf-8?B?cmw4eVppNW0wdjdEajMxVCsyc0lpd2tnSkk3RGxGZjJ6WThtQVg3NkRrWS8x?=
 =?utf-8?B?RS93MVNHN2dwWmVBeEY2bEF4ckZqVjBCb0t2SUhpc1J0QjZPWnhwWHIwN1c0?=
 =?utf-8?B?Y2pxbzIzdnRHcU5LR3RTQXBqRFZzOWR4ZGZkTkFHc0s3cHVRT2dXUDJFY3dQ?=
 =?utf-8?B?d0hVZWJCVWpWSkpaUEFNaE5OaU5MVkJZcGlMMUhuN3lWV3M3ejdPSWpzVzdl?=
 =?utf-8?B?QzVQMHpKdnBqYjU4blBFUENBNXNEWUdYRndJNWVxeittTE1VRjFiWVVMeDgw?=
 =?utf-8?B?aU9EelFBN0dKQzFtYW5MMlFQSm5hRElNMkxJR1FvYVA3RjM2alBLcXZFMkg0?=
 =?utf-8?B?cjVTeEY3WWc2MmJJdWovQ0lobUFkdjk0NzdXUjlJOURQL1BMUmN6ZGFaS0E2?=
 =?utf-8?B?N0dPVVF3c0dDOGMrOFVZalEvMTRQelQrazl6RmxkNUlFNWF5TEROc3VuSU1y?=
 =?utf-8?B?ZWw2b29pUVV6NUNNZlFnZUMyeDNvUmk1ekFaYko1WVBpUnpxWnZWVGppWUhp?=
 =?utf-8?B?Y29YejVDWTc4RlFSQmFOYkJmR0Q1YXVFMk5DTnp1d2t4RTJHMTlXK1ZJNi9y?=
 =?utf-8?B?TFdJK1c4QkJHdnlzWVpiN2t4UUprK0xxS0FrZGtFSnBydXdtVDNyZ01hdTNm?=
 =?utf-8?B?V1ZkMnRlOGpVdkZzV0p0anRVeGxKTzJ3dG91Y3NoZitjdld6SUs4NmpOVkpq?=
 =?utf-8?B?ZTI4UXQ1aTk4NCt1WU4wNmNYUXEzakZiQlY2c1M0TUNuWVNnWjRPb2VjL0tm?=
 =?utf-8?B?YXpRTFhCNDNQSzlUQmU5MzVnWm9HL1ZTYkRUVjBUSmdieThucy9oSTZBN1lx?=
 =?utf-8?B?LzVaTVhsZDJkK3RTampESCt0NmhWVHBaMVpheks3VkV6dGFpemFFQkQ1R0Zy?=
 =?utf-8?B?aFA5enRDdGNqclR5QlMyYm9Tc1E4RVNvbUtaS3djWkVOZEE2N2hkUmRaTmlO?=
 =?utf-8?B?ZisxVStsbkRnUkUwODdKdU9zTTdMVTVhaldIUnJVU0FVNkxqOEZ5dlprZlpE?=
 =?utf-8?B?bldYeVQrUWJ4QXFVaG14Qkd2R2U2YTYwdmdMZ29PemRodTJMNWtOVFZqVEJz?=
 =?utf-8?B?WEo0bFlrdUlpNG80alJqbXRJMi94dDRQa1pwMHFlam5PM3haRlZlVE5UR0Jm?=
 =?utf-8?B?RGpmTDM2LzJxdjFuYVpybUhGUDBGODRMQmxTRVZvQm1ZMGtsRlFIK2NQMTBW?=
 =?utf-8?B?OWtLYzVBcjZ6ZFVBRWJ4Z1g1OTl2L1N4Z2tpY1VzKzFvTGxwdnB1SHVBMURV?=
 =?utf-8?B?d0pTTWh1UURFOXpXYzMyZkZmZG5FOVpTK1VwZWVUcmg0TmhqSHgyQ3JzZHND?=
 =?utf-8?B?a00wa3JXejViWW5sanl5WU5USlpXTENickhRamdWWE1RNDlBeVpVTENGeitj?=
 =?utf-8?B?WUM4djRZclRZRU96aHpXd21aNzFlMXliTE41RVlkeGZ6UkZGN3dNb3VyWk0z?=
 =?utf-8?B?YksyU2s5S2E4MWdmdjdZZlIxU0o5VlVuZWhUcGhBSjdXZFZDZisrakx4VmE3?=
 =?utf-8?B?QzVHRGVsREh3RDlYNElmRTNzcnlhMiszRk5KVDdQNHRjQm4zbjMvV0J2cmow?=
 =?utf-8?B?SEt3MmVNOWZpVlB1YkZLMkhoUXVYZjRaVVRMaUFLVDRlQVk3dUROb01TbVZm?=
 =?utf-8?B?YU9zazZydm9hM1RrRWQxcXczaVhBUG1rRVlpWXhDK2NDWHAwOW5rUUNobDdF?=
 =?utf-8?B?TzFSQnpkdFBaVFE1c2NoeXh4NWhBSWRnVUFyTm40dG4yRW5CQjBSV1N0enpZ?=
 =?utf-8?B?WEhFTDEvSWZ4cldpRURWcUxxZGFad1VhM3hxYjY1ZE96aUttbDdHeVlLSngy?=
 =?utf-8?B?TWJaTkhJcjVoTEFkWVFCNkdkMnArMnBoKzJsZ3B6NDBURzZPanc1RG84TWdr?=
 =?utf-8?B?MVgyVEFZZ2l1YW9wVG9mNGFCYSt2dkYrYnA1aHdjQ2VaSzh6QmpVQngyRGli?=
 =?utf-8?B?Y2drNzVlMHJYL01SNGFBV2hFUWFKbENXajFUcE5MNGl4MS9xd1JONW4xYWpq?=
 =?utf-8?B?VmNhL01ZeGlYQXpybFhpVFVtVmJFdy9LV0E0QkJaSmV3V1dMRkJINnVndm5M?=
 =?utf-8?Q?1TXM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ef84c8-71f8-4bf2-2611-08db36a7ed9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 14:05:07.6854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oqaisinAKEKafoxgSkIyNMOVLwczMCUqoY//P9hQK714rWcOV/H1hBQm9oxsTdUB49ASXJfLY7T/oxR+vAnpXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8908
Subject: RE: [virtio-dev] [PATCH v11 08/10] admin: command list discovery

DQoNCj4gRnJvbTogWmh1IExpbmdzaGFuIDxsaW5nc2hhbi56aHVAbGludXguaW50ZWwuY29tPg0K
PiBTZW50OiBUaHVyc2RheSwgQXByaWwgNiwgMjAyMyAzOjIwIEFNDQoNCkkgaGF2ZSBhIGR1bWIg
cXVlc3Rpb24uDQpaaHUgcmVzcG9uZGVkIHRvIHRoZXNlIHBhdGNoZXMuDQpTb21lIHBhdGNoZXMg
aGF2ZSBwcmVmaXggYXBwZW5kZWQgYXMgInZpcnRpbyIsIHNvbWUgaGFzICJ2aXJ0aW8tZGV2Iiwg
YW5kIHNvbWUgaGF2ZSAidmlydGlvLWNvbW1lbnQiLg0KV2hpY2hldmVyIHRvb2wgaXMgYWRkaW5n
IGl0IHByZWZpeCwgd2h5IGl0IGNhbm5vdCBrZWVwIHRoZSBzaW1wbGUgY29uc2lzdGVuY3k/DQoN
CkRvIHdlIG5lZWQgdG8gYXNrIE9BU0lTIGFib3V0IGl0Pw0KDQoNCg==

