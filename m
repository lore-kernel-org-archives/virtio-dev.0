Return-Path: <virtio-dev-return-13997-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05250CD6E5D
	for <virtio-dev@archiver.kernel.org>; Wed, 11 Oct 2023 11:53:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3F15A2A8DE
	for <virtio-dev@archiver.kernel.org>; Wed, 11 Oct 2023 11:53:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 37FA498685D
	for <virtio-dev@archiver.kernel.org>; Wed, 11 Oct 2023 11:53:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2A20A98684C; Wed, 11 Oct 2023 11:53:03 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 020AA986603;
	Wed, 11 Oct 2023 11:53:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1jGUYFwlyhySOQTRli6q94SPwDM2wr08cbMgRaCKHu/usFGBzdnpoDBfz+zFECXCV36RjCtUzmo/IeIePiLMD6WNsd0iOHhubxeGKfNBuvHeHG5SKk25U7iKvRzymWD32pfG9KgTpPUs5PE/QuF0fP2gK5EZIiFXZ+a+ioHbNfvzYKT/TYIpnglkujibUjUiH5BC8eS+DKclgx7LBqBSGDew5S5GFom25cil6fK5hK7gcKxFQKYhDUfTaxbo90dhZmAZe6qmigbgTACgSTZRBFfKpf0LnovPmc9ou+92sZBM/tSHyrA6VC8pJIbKLdwZlCiUxPk1+gEiLCZMmhMdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiBmHd14+zLSULnNvWFFeAvejARb1waU9cx+PuhYdW4=;
 b=cjvAg9LyDBNOX/2ImnV+lvWhuGr2Io8b3P84Aw43qajZ4rQq7auRusZwG6bx3rG4FA7Vk3tnjBmhQ/1ubFRSfcgZqFGbsPi3Mpz55wNimNAbGjFkIkXxRTT9EEVd3uJxUbxWjmhHefvwaUJP52j7eOFaLMjBoL0XwfPEWKutTC/IXo52YRik8kjFFeBn36iL4idfm6NyUdQj5MILkYm/G1shE8/ZAi+tPl1hL2yTOAdKpFolBH5eRpEVoMs8+Jx9mwbJwlGOap2kGkZT3DCoEqxKoJtSO966qnT2IOVHHW264l68wQ1kd4dFBrfzsbpzYj+yZDw+ZpP51XXoZfE9Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, "Michael S. Tsirkin"
	<mst@redhat.com>
CC: Cornelia Huck <cohuck@redhat.com>, Jason Wang <jasowang@redhat.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>, Stefan Hajnoczi
	<stefanha@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] Re: [virtio-dev] Re: [PATCH 0/5] virtio:
 introduce SUSPEND bit and vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98QgAADDoCAAk+KgIAAS2wAgAEX5ACAAAnDsIAABJcAgAAA3ECAAYB3gIAFKIMAgAEae4CAAAfOcIAAKAeAgAADn6CAADxKAIAAF0QAgAFot4CAAHr+gIASfWUAgAMpyQCAAAUrAIAAFJ/w
Date: Wed, 11 Oct 2023 11:52:57 +0000
Message-ID:
 <PH0PR12MB5481D2B24BB499D18914351ADCCCA@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB5481573D6EE3BE03FB7C3D70DCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvOxraeVB-5g7dJ-KBN=63kpmDfDdqaiQVyDh8egDjsGw@mail.gmail.com>
 <PH0PR12MB5481C11F6D68A892A091E2AFDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e9c482d5-1441-fec5-b55b-f1ac6e81f85b@intel.com>
 <PH0PR12MB5481C57B255B0D5EA6FB109DDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ddbd47c8-6985-2d08-bf98-0e7516f0c3c4@intel.com>
 <20230926064201-mutt-send-email-mst@kernel.org>
 <305d9907-9668-d362-1ff2-49a5e9f90e42@intel.com>
 <20230927113510-mutt-send-email-mst@kernel.org>
 <558fe3d6-0b81-4def-7256-52ac3cbffa8f@intel.com>
 <20231011061508-mutt-send-email-mst@kernel.org>
 <373821b2-1a1e-3bf3-51dc-8af54db85d00@intel.com>
In-Reply-To: <373821b2-1a1e-3bf3-51dc-8af54db85d00@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ1PR12MB6363:EE_
x-ms-office365-filtering-correlation-id: 608d4820-ed5c-49d7-352c-08dbca509cce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yML1PsoAzmeFudl3cpw6e/+nWcTKVPR2A9x+EwqxRk5+6JG8hNXHi5YE4qxbN4pIM3B/GDT0qC0kzGox7T72xVhI7qUMb9t+uQgEVWtwVKFsiavuNvSmdbC+jQzr+8keMNl5IQgRsJWH50sFNhe5FUiXgKHPAcaLzZX1/YyObJ8PV7YGmusbVgVeJmoP+CP6aiURzsIiOwZ/qX42+fhMB+Y5XNZ8wTckvJNJLdyZHEZYSEfEwePABqhTkE/yijAGe2rjqGFyt7WSou1NTZgtNOrvv9IzCwTwM5+QIAl+HcAr5uQVaG3W/lwxXO6lFim0Hut/ki17lxdike0W8hZPawaTqjFLOd0shmdv/PJWklv8b6iTgbHjXpu9wCs25xe3B3VdUfl+x54siSNI8QlgyXeF0hUspABlawxfXErp99LJw+cNIwpUTo+qhv/XsUZ/VVxGdujN8seWrMkAYJZ9kTddEVOGh/yJva2Z+Zu9KKiNOvDZn2RsePWvJRhhawnQ5ohGBGtGkIfQ+adqP3vKQW2DaEM2eWlk4zIAukGzHG1/M8Yl6h5wrmmDT0NlTNacs8YUnJStoYH3yhpruDUFkfTYJ1W23HHyyRgw9DlqHgE7c27LLKkQ7eTX+WKFo7++aqb/ISS7fvq86jLVyvkZMdf2PUG2xCYhxkcif8wStzm4LpJLotE+CB0EDGvnjMVJ+Uxj8LTSY/VU76enMKljKg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(55016003)(52536014)(26005)(4326008)(110136005)(316002)(66476007)(66556008)(66946007)(66446008)(64756008)(76116006)(41300700001)(8936002)(7696005)(2906002)(478600001)(5660300002)(9686003)(8676002)(966005)(6506007)(71200400001)(38100700002)(33656002)(38070700005)(558084003)(86362001)(122000001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RVA4b1QvMlJraDlBM1h0NWxDY2xENzhPYlJ6bWxadGxvZjFxYXNGMks1RmtC?=
 =?utf-8?B?Y1RXTyt0S1JwVng1Yk9PSDljSXBBYUczQ0Jnd1pUcGQ4YU9wMVYyVG9MZ0lN?=
 =?utf-8?B?RnhtWjNTRVpXWncxT2o3Qkw2RmlGWVJZczZLN2plMWNDb2ZEQVFVME9aRlQz?=
 =?utf-8?B?REEvS3llTElEa1I3MTFZc1FEeDg5WlpPL083MTBoVGpYNFlFYjNOei9LMjV0?=
 =?utf-8?B?M0p4a3hLT0V2R1pxOFZFOTBENS9LN3dGeXk1S2hZeVkxZi81RDd1SUM0Zitn?=
 =?utf-8?B?VmpKV0FLbmpUUjdTMjJTdjhxczU3cnBpSjZxSVVkaS9UY05VSkNjdm14UEc2?=
 =?utf-8?B?eEdBRmlaMERodWtIMjlEQWZLQTJtQ244SUY1dzhwbkxFeVZVN3YvVWRXcTdQ?=
 =?utf-8?B?SXUydFZiRVhCQkRqeG1vbkx4d1VkblVPNVd1RjdjYTdWbklVTTVUVUJRbkJl?=
 =?utf-8?B?WDlYVnhsWTJHblRka1NJM2podEJIMlZhYW4wMCs3YTJCc3JmaEJmem5QdFBY?=
 =?utf-8?B?MUZxa25pUE14SHMxNVRNRFIxTExuWDdKWG1ob2lwSVhVTnNId2gwbjFrSlVW?=
 =?utf-8?B?U3FRNVRqSUFPT1FCeVlEU0tmWmpKR1hwbnhCVjZZamFhSmtFODZ4NytDbW9Z?=
 =?utf-8?B?ZDhsY3NCdmVRdnQvMzZ5VTlPVVhNTHJDb0Q4ZDVSU0ZCcXppakZFV2pzZzEv?=
 =?utf-8?B?aDQrWTJ5TlJqSm03S2JUNWt6VUtzaGFQazZvOWo0VjUrOWNtVWxQSE4wWitG?=
 =?utf-8?B?VHhEUFFXOWU2bjZSYUZ4VW9sRTdFQUpjUXZ0VUU0ZEdXNTJrT0QzWjQwd0NR?=
 =?utf-8?B?SXMzUjMzU3cxU05pcUtBcnZsTDNxVkFmVG9IdW9YNmN6dnZrMUkzaGtDYWJr?=
 =?utf-8?B?aWl1c2cyUjhZLzRkZW1FaUN5aFNQVlNvQkgzR3JCcGhBSmhCY04wQTUyM2c5?=
 =?utf-8?B?UUU1K0NOalRtdW5Gc0h3MVJoQ3FsWUxHcmZYNjJHaDd6MG5ESzVMQ2cxZk9W?=
 =?utf-8?B?Rng5T01QazNIVTM3Z0d2U1YycmJXQ2Z4VzlqZ0htQlJJMmFXMklzR2htQ1Zw?=
 =?utf-8?B?QzVHZXJJZm8rNVF3aE9aRWRpb3poeGhGbXNGK2UxTzdjS2Y1Tk9wVEk2Qitx?=
 =?utf-8?B?T3NzclcrdG13bnYxT1ZieFFYWjdSS1QvMlFhTWlhc0duR3FYOW9mT3JPZkYy?=
 =?utf-8?B?eGpzcHVkem9VdmQ5M2kwOHJDaWhqLzR6b1NEQ0pVenNXdzJpTTZhbGxjaXc1?=
 =?utf-8?B?Ynk2Skx4ZGhiSU5CMG1kQk1Qc3RhRk5FMVpmdmVhWFVzN3F3eGdwN0RSTThy?=
 =?utf-8?B?d1dwb010VVlkemxUQjk5aTNSb3VZT1pzYTVsVnRIYUlBNkJTQzZDZ29xQ2pJ?=
 =?utf-8?B?S3duUE51M21xdHhVNEJ1NktBU1U2TGJJZFMrUTRzSHg4cldJdEZrdThJWTR2?=
 =?utf-8?B?NUI5Q095TGlVY0ZjQnBJWmtlY3hUdXc1WUtqUElObndib2NRVkNMekFSdURq?=
 =?utf-8?B?bXlBWGl3Rkc1S3FpTVRXbDcrdm5SWXNUWTh2QVBrbzdEY0xhTkVhM3FjNG9H?=
 =?utf-8?B?ME9oemFWMVV2MnZvZ1VOd0UxblI3V3pNSzVTdlRINWlhUlpNckpVRklKUnRm?=
 =?utf-8?B?S1Q5dVJUb25JZlRkeEN0UTE2VGpML2dBWlJOS3ByV1pmdjRXOHpsb2pvLzln?=
 =?utf-8?B?WkRYQ3U2angzQTRmVHgySEVTNUsvOUJzZVJuSUhqblFkUjlWandJSWZwV0FZ?=
 =?utf-8?B?dWNCQ0ZFdDArRjZmSDlmcHRpUmxzNjBCQW55Q2l1R3FRdFpneGNqTmxXcms3?=
 =?utf-8?B?WXF1dEFpTUpkNDlsdjlsWDRYdHpzTGRuQ1RxSW96NVVJb2YvaXhGUnI1K3Ix?=
 =?utf-8?B?OWY3eUkvNkVaYW9QaW1ma3BqVllXaER3aEsyVGdNNFVXZHpDTUpQajVmdi85?=
 =?utf-8?B?OXRwSWt0QTFwWGo2aTdYOUVqeVlKMFAzQWdrNGxiVlVYOURMSlV0eDUrNUMv?=
 =?utf-8?B?VzVYZS9ZTzdnQUJtMDZUeVNwS0RCYXZvNnBRODZPS0FHU256T3BnUXp5S0Vq?=
 =?utf-8?B?R0xVMUZOKzZtRjFIcDN3ZXFTaFFxZ0VjNGxFWXFoaXg5VU1ReXlSeVFJdjd5?=
 =?utf-8?Q?6H+s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 608d4820-ed5c-49d7-352c-08dbca509cce
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 11:52:57.9711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /S7ri+buIYkTT9Xqf35WWRfVCPyGs697bvIQqxzxO+Qwz6io5QOi9HHK0+WnKMX3itrlZy5Zj+shoEdif6Uvfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6363
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio-dev] Re: [PATCH 0/5] virtio:
 introduce SUSPEND bit and vq state

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFdlZG5lc2RheSwgT2N0b2JlciAxMSwgMjAyMyA0OjA5IFBNDQoNCj4gSSBhbSBzdXJlIEkgaGF2
ZSBub3QgaWdub3JlZCBhbnkgcXVlc3Rpb25zLg0KV2hhdCBhYm91dCBiZWxvdyBvbmU/DQoNCmh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3ZpcnRpby1kZXYvMjAyMzA5MjEwMTEyMjEtbXV0dC1zZW5k
LWVtYWlsLW1zdEBrZXJuZWwub3JnLw0KDQo=

