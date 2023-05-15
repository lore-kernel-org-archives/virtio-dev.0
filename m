Return-Path: <virtio-dev-return-12691-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EA8C7EE22
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 15:50:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8CDEF673AC
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 15:50:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 50B6A986510
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 15:50:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3117E9864EE; Mon, 15 May 2023 15:50:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5A5B1986509;
	Mon, 15 May 2023 15:49:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZbJrDRMO30o8idkpcR12cjc7iDrI4k+MniQtZAoeY45/BUkGyTmQnm/O+ABaLtkxTDufoWd1H3dRp6GCNnqdg50Dk4jnfze1Own8+ehSgM8nuscSe8eS5ID5LJtnh3gD0e+42+5M1NimAawZJGg7BybVsysvNUs6U4ReMvtCVxsqr20kvvBUPbanlhQZ36hc0TevTj//efggPnAoykxAQ+y4kU9OYTzE8TYDKe2vR+lBnOqoS6XMBZSrw98nv169myyF9/b7ncb6NfONPhmzpTeque0+x5R8DVGOz+qEacXtI7V4PNPLVPvwd9Wl1HWKPloLG+Sfyj5SAAFypmbHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGEfOAzWTRoabVEF0wcyHSOYG22Mvm+zYLkGa5QfjgI=;
 b=jN1JZLtgLsf7xjaozrSOWZouvr+L1jJt0+qVcO269sMEtY3dk9UXPnFrxV0nyz7ePqP6+muy+r07j+gGyr571NQqwP/YPIH0lxZTOXMJU6h2jmTPcAwKxiV5N495EXi0Bl/SMNABWGr5JTuYtoQatf2PQQPKbz0ahfVjWalicY+4+a0QjOR2LgyYtgBAvdivr4a/cw2ULj7SmqOyqoEasjTlMw/FR5hr6QLr9q3i94vkFCQ/9UjaZ+c1tYqrLnKcwOyYkHBPlu+cqDbWNOvnHlTCF6a+3DwAXaUpWMYr2IhLCcE3I+F9969n02hMcGNtTcicBanbSFZFI+x2wVv79A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>, Yishai Hadas <yishaih@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ
Thread-Index:
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIADYnEAgACpnQCAAAFGAIAAENkwgAA311CAALAXAIAAZyuQgAXjRYCAAIxikA==
Date: Mon, 15 May 2023 15:49:44 +0000
Message-ID:
 <PH0PR12MB5481CF52380D414AFFBA6A9FDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230506000135.628899-1-parav@nvidia.com>
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <43ec1c8d-7d11-2400-3649-1fe366b1e21b@nvidia.com>
 <20230510121417-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F030A76141320F03956EDC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481CEB307F413E53B03D502DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtm5AS50YmPi6A5=gzZZ9Jm55NEJ3GKOTzv-Z0m5E5J_w@mail.gmail.com>
 <PH0PR12MB5481DE0569EC53A862A4D2E9DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <893b6ec0-a74f-69b7-95a3-988f0f9382a8@redhat.com>
In-Reply-To: <893b6ec0-a74f-69b7-95a3-988f0f9382a8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB7985:EE_
x-ms-office365-filtering-correlation-id: 4c75ea33-1c00-4ff4-4313-08db555c00d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ee2cfAI4TGbrKQFGkRakwMbvdCZD4Ju47X4Z8FGhlHnzMBULfRWs5tgKyP5hJO9VlHzhTjkKR0s2A/gD/Dy7tzt3JnB8cTAwXNJL7X7omdK3nLVRweQZlT3vvzFownkk9Cv6vNEj/jwaBKigTukaWian3042+O93ZaD9LH8BStZz9jMCxOw8jWvTP7/th8s6pgdzhktxUgtKg4lg/xAhrRVnbsAoKAt5S0GCiBUEWSGO/fl/N0VYXkWgDZdeGLbcogb6ONzD546PIxe2lnxesN5+hPNVGJl2ncy4tcvGIYzj+3B5uR3Xn2sdb6vzKdvb2y+6h457X1k8v8yqJo21/87d++U0tUP9H8QHuoDxbJyYM30bYr9H6+L0ZG1t8baBBZUYQugKqQrzxCyrohN4ttIHPKmfNDef/fdRTOHALdMia6i8o4kmY7RKI82/HONTbuUBOWkEYIOuGQHCE237JokE3onozesj7h+Qp0rwFHxWDIcevlxLCHZyH6+thruO5yCv3eyfqzmxNBcAyVCNaVmlhZUnrya13NGdKDr0LmjLuZVbm7sMeUz59C+jRLY/bSfK70XBOKF1PZOKe0USqO+N/WaZheP5DzvCdF67lfDDaHbMOF6d/fbQJouxlsko
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199021)(71200400001)(122000001)(55016003)(38100700002)(107886003)(186003)(83380400001)(9686003)(33656002)(2906002)(41300700001)(6506007)(52536014)(5660300002)(8936002)(8676002)(478600001)(38070700005)(7696005)(66446008)(66556008)(66946007)(76116006)(64756008)(66476007)(4326008)(86362001)(6916009)(316002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXF2RG5hTUlTRS9BdTQ2RGlzeklCZHpFU0FKV2FqVHN1QXg1MVhrNlhML2tI?=
 =?utf-8?B?aUdhb2g3MWFyV2h1c1lSWWIva1ZPcktrRDN2c3VucGJ4SzV3RE1nVUZYakt4?=
 =?utf-8?B?QU9TVFY1bDBnOTJoK09WczRKZzU0cGRPa09DY2FaNU9vaE1GSXBOaGh4ajFh?=
 =?utf-8?B?eEVyZmtVeGpUWW5FU25IN3JBS3BKMDEvZFQxUEJzVXduNjlyV2VkeHNqaDhN?=
 =?utf-8?B?YVUybFZEM1VjWnBTUGNNR3FLMFpOYUd3Ujd5dDFJWnAveU1IbmJWb1ppb3J1?=
 =?utf-8?B?aThHTTIwR0VrenNtWHBYNFg3VW1FRlFJbVJjbjZ0eHlBS2JBY010Y1VVREUr?=
 =?utf-8?B?TmZLcEhSSEViUURBenJoNU14bnhtYm1saVNmWklBY0dGeW9CNmNhT3Rsekd5?=
 =?utf-8?B?M3ZJa2JqeVNabjBnR254cEgzZTFlQXZ1ZVYydjJrbXhrVTlhWjYzNW5GYjZh?=
 =?utf-8?B?cmVxQ0hNRVNKZmo4VklTTG5NQ3R4Tzlnd1VNQXpmeHBkbVVwbUxIejUvV3ZM?=
 =?utf-8?B?eUJFYkNFRmJTUVdzNmtMQkEyMCtYYkd5YkpKMVR3NlFtVlF5QXV0Z1JkK0dT?=
 =?utf-8?B?b0hPTzRsUGREKzczc2lkNkgybzRaRFNjc21kRzBRcE9EMEhBSXNIRmlxNjkx?=
 =?utf-8?B?RVlQUXgxL1dtR0FZb3NZYStSRVR6Z25WYUJNaHFpUHZMQk04YU5GNXFYQ0tU?=
 =?utf-8?B?aWd6dVpMd3UrUTVjZWNlZnZLanFOditrN2J0Q2pnK1R5MUE5dXplcmZRNjFJ?=
 =?utf-8?B?b3FJOG5YTUlhcldjSjFiZ2pVREZDUFRDNGdLNitYV2ZOTU9QRUQ4MmlPVzQ0?=
 =?utf-8?B?endYOHhJYVJLQmxQS2JNb3Y5YmtWQjR5ZWxWYVMzOUZRYWJnSE1HSVNRQ0h3?=
 =?utf-8?B?N1FiNXBKbzIzT0k4bzdjYVA2aStxSURIb2FERTMwUUsveWZNSjlWTU15R1Mw?=
 =?utf-8?B?eGJxNW94cGE1cjJUK0lGcy9haEMwbjRyRXdHejNyV0RwS043RFpHaHlmYSs5?=
 =?utf-8?B?QWRnSU0vanUvNStpWVFyTVNoV2V4QVFoMzRSazZRUjI4cWg4U1owU2Nhekl4?=
 =?utf-8?B?YmcrUWdDZ1M2NUxycFpoTUFRWmdBR2M1NENLMUJQZ1dXK3J5RGxrM1pkVC9V?=
 =?utf-8?B?dUVnTU94Y3JSYU9HVHNhQjNyTUVFUlkrT2k5WEtORHlPb2xVWFgyeTRwUFg3?=
 =?utf-8?B?SDlkYVpYaWFqY05vWGZWdHFvL2pibk80eHUxZjlsbyticGFPRmptMmlvaGlM?=
 =?utf-8?B?V1JiNkdsYzdwS1QvbVlhL1kxNmd6SzJDS3EvQjBhM2h3Um9ZSG1SSE1hVW1r?=
 =?utf-8?B?TTZOaXhPaHMwdkRaL2xCSzNWalEzRkRqeU4xV0tjNXlCeHNVa3FiQThnSnBJ?=
 =?utf-8?B?QzJCbEZuZzFPQ2tjd2dqSDNpbzQvdGhRbEZRVTFKbkVEc0JJR0IydkZrT0RG?=
 =?utf-8?B?UG5GUm96TmlHNWs4OVN0dzNXcEVrRUxLMnlJaUdTR0xWNnp1bWZHUjBLdE45?=
 =?utf-8?B?QWx0SjdzWXBzSzFybGxzaXNLOEhTVi9SVm1QdGVkYjlONmJuRmYvZUsyc1d6?=
 =?utf-8?B?Z1AxaG1RODc0ekRvSC9vNFByTEpGMlh3WWUxNXFlUmsxcFJ0L3F2dWZzdW9E?=
 =?utf-8?B?VHQ5ekRubXNEWEdGNDdJSFZaQnl5anlnTEF3cjBWdHdoa1JMUnhieTBXdy8z?=
 =?utf-8?B?M0I2c1lZUWt3aTlBSUFEU2FoZTdTQUJKSTl4cTk0bjBhRXpNQzNNWUp6SVo1?=
 =?utf-8?B?TEZZdjVYalUvWFBzN2Y2OXlOTzA5U1pTb1FldDlEVW4zZ0ZYRWw5amtMSGpP?=
 =?utf-8?B?L0ZSRUJreldzQkM0cTU0UjhETVJ4R2lPWnhRSE1OSnhKTXVOYjFLZjREQjBI?=
 =?utf-8?B?MHVEakRJZU1oYlBGc294Rmg5ZC9SdjZXckM4d2E3NVFEeFlpRXdDaDUwa3RU?=
 =?utf-8?B?eFlsYUJoWEx1S2xBWXdLUFhsVHhMM0NqdkY1YmxRcCsrTnByL3FHS0VhODZT?=
 =?utf-8?B?UGNxcEovd3YrOUh0VHFVSTBGSEdKd0NrZWRHaVZvdmVRVW9NSVhUTkVRYWNa?=
 =?utf-8?B?MlNVaGZBY2U5OG94cEkxWnEwc3pwc1pXTjhmZDMrZjB0Tk5TQWIzNUNndjVt?=
 =?utf-8?B?NGJEU2FVVUFTUEFLQ3B1cHZSb2pYUHVXaUJMbTBGSTdGK0NoK1UvTmp3Nk1r?=
 =?utf-8?Q?VTUKh8ypQenP1nf6hr14514=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c75ea33-1c00-4ff4-4313-08db555c00d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 15:49:44.2015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V0x5g6HHymxeaDwEeTUza2pVdAAb86IUwwBlVOAWjk1YoA+EF5/l8aooYzSb9mCv79XVH0+gAF/20nokWvhtcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7985
Subject: [virtio-dev] RE: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IE1vbmRh
eSwgTWF5IDE1LCAyMDIzIDM6MTEgQU0NCg0KPiA+IEl0IGlzIGp1c3QgYnVuY2ggb2YgYWRtaW4g
Y29tbWFuZHMgaW4gdGhlIG5ldyBTSU9WIG9yIHZpcnR1YWwgdmlydGlvIGRldmljZQ0KPiBjaGFw
dGVyLg0KPiA+IEl0IGlzIG5vdCBhIHRyYW5zcG9ydCBjaGFwdGVyLg0KPiANCj4gDQo+IFByb3Zp
c2lvbmluZyBjb3VsZCBiZSBhIHBhcnQgb2YgdGhlIHRyYW5zcG9ydC4gRm9yIGV4YW1wbGUgU1It
SU9WIGFsbG93cyBzdGF0aWMNCj4gYW5kIGR5bmFtaWMgcHJvdmlzaW9uaW5nLiBJZiBhIHZpcnRp
byBkZXZpY2UgbmVlZHMgdG8gYmUgaW1wbGVtZW50ZWQgaW4gVkYsIGl0DQo+IG5lZWRzIHRvIGJl
IHByb3Zpc2lvbmVkIGZpcnN0Lg0KPiANClByb3Zpc2lvbmluZyBhIGRldmljZSBieSBhZG1pbiAh
PSB0cmFuc3BvcnQgZ3Vlc3QgZHJpdmVyIDwtPiBkZXZpY2UgY29tbXVuaWNhdGlvbi4NCg0KVHdv
IHZlcnkgZGlmZmVyZW50IHRoaW5ncy4NCg0KPiANCj4gPg0KPiA+Pj4gQW5kIHRoZSBtb3RpdmF0
aW9uIGlzIGFsc28gY2xlYXIgaXMgdG8gcHJvdmlkZSBjb21wb3NpbmcgYSB2aXJ0aW8NCj4gPj4+
IGRldmljZSBmb3IgdGhlDQo+ID4+IGd1ZXN0IFZNIGZvciB0aGUgYmFja3dhcmQgY29tcGF0aWJp
bGl0eSBmb3IgMS54IHBhcnQgb2YgdGhlIHNwZWNpZmljYXRpb24uDQo+ID4+PiBJdCBzZWVtcyBm
aW5lIGFuZCBpbmRlZWQgb3J0aG9nb25hbCB0byBtZSB0aGF0OiBpdCBpcyBmb3IgYmFja3dhcmQN
Cj4gPj4gY29tcGF0aWJpbGl0eSBmb3IgYWxyZWFkeSBkZWZpbmVkIGNvbmZpZyBmaWVsZHMgZm9y
IGV4aXN0aW5nIGd1ZXN0IFZNIGRyaXZlci4NCj4gPj4+IEl0IGRvZXMgbm90IGNvbmZsaWN0IHdp
dGggdGhlIGNmZ3EvY21kcSBpZGVhIHdob3NlIG1haW4gcHVycG9zZSBpcw0KPiA+Pj4gZm9yIHRo
ZQ0KPiA+PiBuZXcgY29uZmlnIGZpZWxkcywgbmV3IHVzZSBjYXNlcyB0aGF0IGRvZXNuJ3QgcmVx
dWlyZSBhbnkgbWVkaWF0aW9uLg0KPiA+Pj4gU3VjaCBjZmdxIHdvcmtzIGFjcm9zcyBQRiwgVkYs
IFNGL1NJT1YgZGV2aWNlcyBpbiB1bmlmb3JtIHdheQ0KPiA+Pj4gd2l0aG91dA0KPiA+PiBtZWRp
YXRpb24uDQo+ID4+DQo+ID4+IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB0aGUgY2ZncS9jbWRx
IGNvdWxkIGJlIGRvbmUgb24gdG9wLCBzaW5jZQ0KPiA+PiB0aGUgY29tbWFuZHMgYXJlIHBhcnQg
b2YgdHJhbnNwb3J0IHVubGVzcyBJIG1pc3Mgc29tZXRoaW5nLg0KPiA+Pg0KPiA+IE9uIHRvcCBv
ZiB3aGF0Pw0KPiA+IGNmZ3EvY21kcSBpcyBqdXN0IGFub3RoZXIgcXVldWUgbGlrZSBhbnkgb3Ro
ZXIgVlEuDQo+ID4gaXQgaXMgb3J0aG9nb25hbCB0byBhY2Nlc3NpbmcgMS54IHJlZ2lzdGVycyB1
c2luZyBncm91cCBvd25lcidzIHF1ZXVlLg0KPiANCj4gDQo+IEkgdGhpbmsgdGhlcmUgaGFzbid0
IGJlZW4gYW55IHByb3Bvc2FsIHRoYXQgY2FsbCBhbnkgdmlydHF1ZXVlIGxpa2UgY2ZncS9jbWRx
LiBTbw0KPiB1c2luZyB0aGF0IG1heSBjYXVzZSBhIGxvdCBvZiBtaXN1bmRlcnN0YW5kaW5nLiBJ
IHRoaW5rIHRoZSBjb250ZXh0IGhlcmUgaXMgdG8NCj4gcHJvdmlkZSBvciBleHRlbmQgdHJhbnNw
b3J0IGZhY2lsaXRpZXMgdmlhIGEgdmlydHF1ZXVlIG5vdCBzb21ldGhpbmcgbGlrZSB0aGUNCj4g
Y29udHJvbCB2aXJ0cXVldWUuDQpUaGUgY29udGV4dCBpcyB0byBjb21wb3NlIGEgUENJIGRldmlj
ZSBmb3IgYSBndWVzdCB3aGljaCBmb3IgdGhlIGN1cnJlbnRseSBkZWZpbmVkIGZlYXR1cmVzLg0K
T25jZSBhIG5ldyBhdHRyaWJ1dGUgaXMgZG9uZSB1c2luZyBjZmdxL2NtZHEgdGhlcmUgaXMgbm8g
cHJvYmxlbSBvZiB0cmFuc3BvcnRpbmcgaXQgdmlhIGl0cyBncm91cCBtZW1iZXIuDQoNCkFuZCB0
aGVyZWZvcmUsIHNheWluZyBhbnkgbmV3IGF0dHJpYnV0ZSBhbHNvIHRvIHJpZGUgb24gc2FtZSB0
cmFucG9ydHEvYXEgdmlhIGlzIG5vdCBhcHByb3ByaWF0ZS4NCg0KPiANCj4gQWRtaW4gdmlydHF1
ZXVlIGRvZXNuJ3QgcHJldmVudGluZyBhbnl0aGluZyBmcm9tIGxldHRpbmcgSU1TIGdvIGRpcmVj
dGx5IHRvIHRoZQ0KPiBkZXZpY2UuDQpCdXQgdGhlcmUgaXMgbm8gYXEvY2ZncS9jbWRxIGRlZmlu
ZWQgZm9yIHRoZSBndWVzdCwgc28gd2l0aCBjdXJyZW50IHByb3Bvc2FsIGl0IGlzIHByZXZlbnRl
ZC4NCg0KPiANCj4gDQo+ID4gICBMb25nIGRpc2N1c3Npb24gd2l0aCBUaG9tYXMgb24gSU1TIHRv
cGljLg0KPiA+IEkgd2lsbCBhdm9pZCBkaXZlcnRpbmcgdG8gdW5yZWxhdGVkIGRpc2N1c3Npb24g
Zm9yIG5vdy4NCj4gPg0KPiA+Pj4gT3IgcHJvcG9zZWQgY29tbWFuZCBpbiBbMV0gc2hvdWxkIGJl
IHRhZ2dlZCBhcyBzaW92X3IxLCB0aGVuIHRoaW5ncyB3aWxsDQo+IGJlDQo+ID4+IGNsZWFuZXIu
DQo+ID4+DQo+ID4+IE1heWJlIHdlIGNhbiBzYXksIG9uZSBvZiB0aGUgaW1wbGVtZW50YXRpb25z
IGlzIHNpb3ZfcjEsIHNpbmNlIGl0IGNhbiBiZQ0KPiB1c2VkDQo+ID4+IHRvIGltcGxlbWVudCBk
ZXZpY2VzIGluIG90aGVyIHRyYW5zcG9ydC4gT25lIG9mIHRoZSBtYWluIG1vdGl2YXRpb25zIGZv
cg0KPiA+PiB0cmFuc3BvcnQgdmlydHF1ZXVlIGlzIHRvIHJlZHVjZSB0aGUgdHJhbnNwb3J0IHNw
ZWNpZmljIHJlc291cmNlcyB0byBlYXNlIHRoZQ0KPiA+PiB2aXJ0aW8gZGV2aWNlIGltcGxlbWVu
dGF0aW9uLg0KPiA+Pg0KPiA+IFllcywgdGhlIG1haW4gbW90aXZhdGlvbiBhcyBmb3IgYmFja3dh
cmQgY29tcGF0aWJpbGl0eSBmb3IgdGhlIGN1cnJlbnRseQ0KPiBkZWZpbmVkIGZlYXR1cmVzLg0K
PiA+DQo+ID4+PiBXaXRoIHRoYXQgSSBkb24ndCBzZWUgbGVnYWN5IDMgY29tbWFuZHMgYW55d2F5
IGNvbmZsaWN0IHdpdGggWzFdLg0KPiA+PiBJdCBkb2Vzbid0LCBidXQgaXQncyBub3QgZWxlZ2Fu
dCBzaW5jZToNCj4gPj4NCj4gPiBJIGRvbuKAmXQgc2VlIGhvdyBtYWtpbmcgMyBjb21tYW5kcyB0
byA5IGNvbW1hbmRzIG1ha2VzIGl0IGVsZWdhbnQgYnkNCj4gZG9pbmcgYmlzZWN0aW5nIG9mIHJl
Z2lzdGVycyBvZmZzZXQgaW4gaHlwZXJ2aXNvci4NCj4gDQo+IA0KPiBPciBpdCBuZWVkcyB0byBi
ZSBkb25lIGJ5IHRoZSBoYXJkd2FyZSBhbmQgY3Jvc3MgcmVnaXN0ZXIgd3JpdGUvcmVhZA0KPiBu
ZWVkcyB0byBiZSBoYW5kbGVkIHRoZXJlIGFzIHdlbGwuDQo+IA0KVGhhdCBpcyB0aGUgbGltaXRh
dGlvbiBvZiBsZWdhY3kgYW5kIGRldmljZSBjYW4gYWx3YXlzIF9kZWNpZGVfIHdoZW4gdG8gYXBw
bHkgdGhlIHBhcmFtZXRlciBsYXRlciB3aGVuIGVub3VnaCBiaXRzIGFyZSB3cml0dGVuLg0KR2l2
ZW4gaXRzIGNvbnRyb2wgcGF0aCwgaXQgaXMgbm90IGFuIG92ZXJoZWFkLg0KDQo+IA0KPiA+IEl0
cyBzYW1lIHRoaW5nIHVzaW5nIG1vcmUgb3Bjb2Rlcy4NCj4gDQo+IA0KPiBEbyB3ZSByZWFsbHkg
Y2FyZSBhYm91dCB0aGUgbnVtYmVyIG9mIG9wY29kZXM/IEkgdGhpbmsgd2UndmUgcmVzZXJ2ZWQN
Cj4gc3VmZmljaWVudCBzcGFjZXMuDQo+IA0KSSBkb27igJl0IHNlZSBvcGNvZGUgYXMgcHJvYmxl
bSwgd2UgaGF2ZSBwbGVudHkuDQpBbmQgaGVuY2UsIHdoZW4gdGhlcmUgaXMgYSBkZXZpY2UgdGhh
dCBfZG9lcyBub3QgaW1wbGVtZW50IGNvbmZpZyBzcGFjZSBmb3IgU0lPVi9TRiwgaXQgc2hvdWxk
IGJlIGludHJvZHVjZWQuDQpJdCBpcyB0aGUgaW50cm9kdWN0aW9uIGFuZCBiaXNlY3Rpb24gYXQg
dGhlIGh5cGVydmlzb3IgbGV2ZWwgdW5uZWNlc3NhcnkuDQoNCkFuZCBJIGRvbuKAmXQgaGF2ZSBv
YmplY3QgdG8gaXQgZWl0aGVyLCB0aGUgbWFpbiByZWFzb24gaXM6IEkgZG9u4oCZdCBzZWUgaXQg
YmVpbmcgdXNlZnVsIGZvciAxLnggYWNjZXNzIGdvaW5nIGZvcndhcmQuDQoNCj4gDQo+ID4NCj4g
Pj4gMSkgTW9kZXJuIHRyYW5zcG9ydCwgYWRtaW4gdmlydHF1ZXVlIHdpdGggd2VsbCBkZWZpbmVk
IHRyYW5zcG9ydA0KPiBjb21tYW5kcw0KPiA+PiAyKSBMZWdhY3kgdHJhbnNwb3J0LCB3b3JrcyBt
b2UgbGlrZSBhIFBDSSB0cmFuc3BvcnQgb24gdG9wIG9mIHRoZSBhZG1pbg0KPiA+PiB2aXJ0cXVl
dWUNCj4gPj4NCj4gPj4gVHJhbnNwb3J0IHZpcnRxdWV1ZSB0ZW5kIHRvIGJlIHRyYW5zcG9ydCBp
bmRlcGVuZGVudCwgYnV0IDIpIHRpZSBpdCBzb21laG93DQo+IHRvDQo+ID4+IHRoZSBQQ0kuIFRo
YXQncyB3aHkgSSBzdWdnZXN0IHRvDQo+ID4+DQo+ID4gVGhlIDQgcGF0Y2hlcyBhcmUgbm90IHRy
YW5zcG9ydGluZyBhbGwgdGhlIFBDSSB0aGluZ3Mgb3ZlciB0cmFuc3BvcnQgVlEuIGl0IGlzDQo+
IG5vdCBhIHRyYW5zcG9ydC4NCj4gDQo+IA0KPiBJdCByZWFsbHkgZGVwZW5kcyBvbiB0aGUgZGlm
ZmVyZW50IHZpZXdwb2ludC4gDQoNCllvdSB3cm90ZS9hc2tlZCBmb3IgIlBDSSB0cmFuc3BvcnQg
b3ZlciBhZG1pbiBxIi4NClRoYXQgbWVhbnMgUENJIGNhcGFiaWxpdGllcywgUENJIGNvbmZpZyBy
ZWdpc3RlcnMgYW5kIGFsbCB0aGluZ3MgZGVmaW5lZCBpbiB0aGUgUENJIHRyYW5zcG9ydCBzZWN0
aW9uIHRvIGdvIG92ZXIgdGhlIEFRLg0KVGhpcyBpcyBjbGVhcmx5IG5vdCB0aGUgb2JqZWN0aXZl
IG9mIHRoZXNlIDIgcGF0Y2hlcy4NCk5vciBpdCBpcyB5b3VyIHByb3Bvc2FsIG9mIHRyYW5zcG9y
dCBWUS4NCg0KWW91IG9ubHkgd2FudCB0byBleGNoYW5nZSBjdXJyZW50bHkgZGVmaW5lZCBjb25m
aWcgcmVnaXN0ZXJzLCBpbnRlcnJ1cHRzIGFuZCBub3RpZmljYXRpb24gY29uZmlndXJhdGlvbiB1
c2luZyBBUS4NCg0KVHJhbnNwb3J0IFZRIGlzIE5PVCB0cmFuc3BvcnRpbmcgYWN0dWFsIGRhdGEs
IGl0IGlzIG5vdCB0cmFuc3BvcnRpbmcgbm90aWZpY2F0aW9ucyBldGMuDQpJdCBpcyBqdXN0IGEg
Y29uZmlnIGNoYW5uZWwuDQpIZW5jZSwgdGhleSBhcmUganVzdCBjb21tYW5kcyBub3QgYSAiZnVs
bCB0cmFuc3BvcnQiLg0KDQo+IFRvIG1lLCBhZG1pbnEgaXMgbm90DQo+IHNwZWNpZmljIHRvIFBD
SSwgc28gdGhpcyBwcm9wb3NhbCBsb29rcyBtb3JlIGxpa2UgYSBwYXJ0aWFsIHRyYW5zcG9ydA0K
PiBmb3IgbGVnYWN5Lg0KSXQgaXMgbm90IGEgcGFydGlhbCB0cmFuc3BvcnQgZm9yIGxlZ2FjeS4N
CkEgZnV0dXJlIHRyYW5zcG9ydCBtYXkgYmUgYWJsZSB0byBkbyBmb3IgU0lPVi9NTUlPIGJ5IGFk
ZGluZyB0aG9zZSBncm91cCBtZW1iZXIgaWRlbnRpZmllci4NCg0KSGVuY2UsIEkgYWdyZWVkIHRo
YXQgY29tbWFuZHMgaW4gdGhlIHRyYW5wb3J0dnEgcHJvcG9zYWwgaXMgZmluZSwgYXMgY29tbWFu
ZHMsIG5vdCBhcyBuZXcgdHJhbnNwb3J0Lg0KDQo+IA0KPiBTbyB3ZSBoYXZlDQo+IA0KPiAxKSBh
bGwgY29tbWFuZHMgdmlhIFBDSQ0KPiAyKSBhbGwgY29tbWFuZHMgdmlhIGFkbWlucQ0KPiAzKSBw
YXJ0IG9mIHRoZSBjb21tYW5kcyB2aWEgUENJIGFuZCB0aGUgcmVzdCB2aWEgYWRtaW5xDQo+IA0K
PiBUaGlzIHByb3Bvc2FsIGdvZXMgdG8gZm9yIDMgd2l0aCB0cmFuc3BvcnQgc3BlY2lmaWMgY29t
bWFuZHMgd2hpbGUgSQ0KPiB0aGluayB3ZSBuZWVkIHRvIHRyeSAxIGFuZCAyIHRoZW4gaXQgaXMg
bW9yZSBnZW5lcmFsIGFuZCBpdCBoZWxwcyB0bw0KPiBhdm9pZCBkdXBsaWNhdGlvbiB3aXRoIGZ1
dHVyZSBmZWF0dXJlcy4NCj4gDQpBbGwgbGVnYWN5IGludGVyZmFjZSB2aWEgQVEuDQpBbGwgbW9k
ZXJuIGludGVyZmFjZSBhY2Nlc3MgdmlhIFBDSSBvciBpdHMgb3duIHRyYW5zcG9ydCBiZXR3ZWVu
IGRyaXZlciBhbmQgZGV2aWNlLg0K

