Return-Path: <virtio-dev-return-12957-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC64FEB64DA
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 12:38:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 298174290A
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 12:38:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 18CDF98644F
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 12:38:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0B355986399; Mon, 19 Jun 2023 12:38:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E8517986397;
	Mon, 19 Jun 2023 12:38:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYs+x5aGIKeYP/ku6f22VY1wyQDWTXh6V1n4s3Hjw3F3iM+MoqSu+jYXQh1jnDWNQoFUJmW9WDnRUsAiIsjKBqqmWAXL3s0tvie1hYI7QUZirnx+7U21wRD1g5HJTHCr0ehJcW6I2DVa4NqvB76vXBTbaptfcLjbO2IbwBu6Deb5Axx13jIyGgsDGbV4Te/YSpvgBw03e8E9VeWeRRr2yqAU1o6KNRFd3/GVzUqsd/PICZcrPxrr7US8pFD+5XOJgeYhwa/yMm3yNXisQ3kFKY20NRrS7Ld2jKVpujoWMKB3k7ly3vQaSq5VVBMeJJxti029WTHMy04Kk2sg+HWLCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1xCTWFd79MMYowiBLsHwbvZ912DC3QQ5HiSuDr8wrc=;
 b=mWmtHmNcH8gBmp81M2++WHM/sYYJLCK9uB3egd5WO4h1v22W5GqkwZ774ejMPSXatFlnKvsCvl9p2WHrDYChojOvjh+IYZayvcJDkvSBmf6l99WsGrukachxxWGco3+Eepsy4luC9HsDAptBqj8RzpQHu8vMYEEZX3eoZBG/xLNuc+AxrCB2vNhxBoqC26g1nQxOvB72FX874Qg39qw8XqAdP5lzrL4CYg1H2zIuVlFGCkbWBiNf0MsENcufygicDx2iuXek3IbU9Kkz2a/9bgigRgzBmhuHSkpxGVHIz484vWmaVgCRVfOo/x9ArDqSQ31BbbYhTwpRfp3NNqlUyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sburla@marvell.com" <sburla@marvell.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb
	<maorg@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v6 0/4] admin: Introduce legacy registers access using AQ
Thread-Index: AQHZnhzH08HObjyFZEiE3Fo/Ogfm06+SGI+g
Date: Mon, 19 Jun 2023 12:38:29 +0000
Message-ID:
 <PH0PR12MB54815F02CE10368D6204EC8CDC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230613173015.1244486-1-parav@nvidia.com>
In-Reply-To: <20230613173015.1244486-1-parav@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB7164:EE_
x-ms-office365-filtering-correlation-id: 52160aaf-6f26-453e-df64-08db70c21592
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Eaj+/svrm10BB6AIcV8HIo/gombwLBR1YUKxo2eHMZuDiIIslNQlnJ4ELm+m10OWnhvIOBPrb4ASLUpFXkrm5PLNNbIpWI4hU/2/PCDGJtv1A045+cl913+zfXUKWWPUEvlfCrmp23LSrfGRrtaPokskTu/g4YSmWdBBDYP6ZM9YxTtCkyabk6+m4QIwWadaOd0kTCQvK/KkJf+/3z54Opw++kkGC/3bBoyPT7FCJqF6hP3Fay4D3kayXReznndZ9/15ITcn+wEg87UprfjejaJAblTDLK5/2lFEWXE3nYTAdgxH+X+LUk0EsmH0pAmc44ulrfjHTEK8BIzVpmnD0Dd4VGDiZ+kjxcHeSXXahGymU2+Is9Ao++/dCIhODrdvnM4pwbJq9uNiD0M453MA831Z+zwRsT4srHFqBhDdS68Co52vxbqek/SirtmFmOgXwIj9w9Pn/TKZ5C5lsV4TR5g6eI9gd3bcuQaFkYq7BJPypr+X040Kco67ijB2CPoUb2TlqMY6NBYNhmP3gESX+Ga3xIowOO16aMU3YKaRb7Rbtzp6pCME5516v07Pxfon2G7xyrJslw/SKRNhjtD0P99JqwxOaj0DcqJg0Bmpi5+GqV7W1I42+X09fbJzCWbR/YsRbny0rZdRXshqt0s4/6POxDh14G1nBsF/yNecARs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199021)(86362001)(55016003)(33656002)(122000001)(38100700002)(38070700005)(478600001)(71200400001)(7696005)(110136005)(54906003)(107886003)(966005)(8936002)(8676002)(52536014)(316002)(26005)(5660300002)(4326008)(66946007)(66556008)(76116006)(66446008)(66476007)(64756008)(2906002)(41300700001)(6506007)(186003)(9686003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TjF1YUFFNTNrSy9qeVZ5UUQrOThwbVBPT096aVBlc3E4blBVdkFjM1FrTW5Z?=
 =?utf-8?B?WUdLdHJUY1dJMmNSY1FIT1ZMS0cvWEpESWpuY21XU3J0YTdSUVNtdlQ3elY0?=
 =?utf-8?B?L1BxY091eW5aOE1pUDV3b3ZDK3lIODJ0U2E1dmo2UlQveXMxbjVSR0pwTkNp?=
 =?utf-8?B?SjBQYnZ4WDBSMWQydHp6cXBhdGl4Ums2Nm1waENpV05XMStQVXNNc0Z6cmY2?=
 =?utf-8?B?QzlUVXNsbk9LdVdZREJUQjFHdGtucEhjczZLUTBhSnFUYTIwamZkWXlhY1NK?=
 =?utf-8?B?bGM4YlNLSXo1dlRGSUlnRWhtS0FFMUd3WEZKa3JLY3FkK1ZoMXZ0dkovbzM4?=
 =?utf-8?B?dW02UE9EL1YreUp6THMvVEE1WjZ0bmlTdHh4THV5YmdwTW9NOUFVTmNUSjkx?=
 =?utf-8?B?Q3lxZzZXZGoydjllRzlyRFpxZEorUTNOek1iczlMcGZpdUI0S0ZMRFAvNU9U?=
 =?utf-8?B?b3ZuS1RMYXppNWY1OTVUeFV2SzFOQlFwWCttZGsvLzBqV0duV1FQbjU5emZO?=
 =?utf-8?B?WEpLWlI3elN0RXlPbVBJUkNuUmI5d244V0JrdXFNSnU2VlAvVE9xaVg4MW85?=
 =?utf-8?B?bTBGWEhqUkNuOHppcTNlKzVHcGNGSit2K2RSZ2h0VnBZLzBvamc1cWczbGp6?=
 =?utf-8?B?QjdxQnd5amYzSFRvVkoranlkZ1BkUTIvcUJCZnZmaERXYVZDZ3Q0OFJNVzM5?=
 =?utf-8?B?eHJxN2lnbXlmTk9obHo2ZDZDVFphU2xYd3JkNWxSNzBJMzkrSUd4SWEyTGdt?=
 =?utf-8?B?bEVITGZvY0JIVHVIWHhTL09qZ0pNTTFCRzJwS00wRGw1R1dyNGF1K1NhSW5C?=
 =?utf-8?B?bnA5alJiYmpwZlpGRVBwYjc5aE9pT1BueFZleHRTOXJrMzk3aWg5YzA0c0Ey?=
 =?utf-8?B?WEtNa3QyVnJ0VzEvUjVkS2RXR1VOQTc3MWRVZmdzRlk4ZmpUcHFJVGJublUy?=
 =?utf-8?B?MDJFWGRBMzczUksrWGZDUlpJd1JUb2pqWW80WDVTajN1bEJpUCtyZnhGM3JY?=
 =?utf-8?B?YVd3VlQ4dDNyN3kwam9kaVJHMjY0OGFjYTczMEpQcGJiNXBqbUlLNnlEc04r?=
 =?utf-8?B?eVZ2ajdiRHpXakV1MTlhNnVZMWFMWFZid3JQQkVpVjg1TUpDdTZUQUpaQlVZ?=
 =?utf-8?B?TUdFKzBuNHJTU2Q0ekwvbURrRW5HYW9hNVhkRm9VNU1wSFhSVjNncVZ6VXdV?=
 =?utf-8?B?Vkw5eHVwUFdBTVFudUl5NWQvbW9vdUZmNURvZDYvakZrZHJYY2xjaTJQdUJI?=
 =?utf-8?B?VkY4eXpGd2w0eGYrWkZ0MUphNWxFWGxDZU5JOFhDZG9Fd1FVbWJVT3d6Mlpn?=
 =?utf-8?B?K1BDQVRHdFVlUTB6clNpZXBKbUdNZDJGTkFtMlo3ZlJ0SHVXVmczRlU1K3Y0?=
 =?utf-8?B?R0pJQ1premdNTmhoMnkyZ0RiSDBFMzlyRWE3QUNRRTY4cTk3amM3MUl0N2lG?=
 =?utf-8?B?RFJsRDZndFN5VHEwR2JQWEozbEszZnRZeGdaYUQ4M1pzdERXWE05SUJLY1V2?=
 =?utf-8?B?MDVoZVEwTkNpcDUvZjA0ZTJ1bElDSWl2ZXducTZ0WUpnZ3hIemdqNms3UG8v?=
 =?utf-8?B?b1F0Z1A4VHA0dVZlQTE5eXV2OUdYSkpqbHNjeldKVmw5VG1wY1Q0UytTaGps?=
 =?utf-8?B?eVlZVk5YVmdtUmtpekNRYVNaMlhTNWhxTkU0WDRocUwxdXJlSGRBcWI3ejRP?=
 =?utf-8?B?NHVwV2JiQjNaTWIzbGZTNE5aTEZuSHlrLzg0UkoxOUdJZ0ltL3lHbWk1Z3lO?=
 =?utf-8?B?Y05EWklmZ0ZzdUdTSW9oQnY3RmpqSVZkK2Z0MHpOQmlpMi9OUXAwMkYzSTVL?=
 =?utf-8?B?ajdBRFQ4UDVheG0rVUJpcmVaSVBpQ3BCT1hOeEdXeDhUa2gydTJidnhOYkhH?=
 =?utf-8?B?MWNUWWFrOHNRdlFyY3F6MklKQVhhWjhpS2p2Mm1uZ1VJbGt6MTdEQ0hIUmM3?=
 =?utf-8?B?dkk5d3d1WUlVQXF4d0I5QWxac0U5endvcll5cDlVMkdsSFVIaHMxclU0WVY2?=
 =?utf-8?B?dTRaZmNGdWR6ZmtYTzVzbWpJU2ovWlVoQWdTRHZGODN3ZlBheFhBamV3ajQ4?=
 =?utf-8?B?YVlFcmhXbGdWL1pOK2JPUTBUcHp1ZlI3MHk3cDlZY1VYVVRjN29rM3pMN0Fi?=
 =?utf-8?Q?IzyQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52160aaf-6f26-453e-df64-08db70c21592
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 12:38:29.0486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZXuq8ChguV74EWCpenD6wGqXQON+FoqfcXz8eOashdzxfJ+8h4mlpD4dK6Wg6sgasZzfopdTH9mh3tJh99kvTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7164
Subject: [virtio-dev] RE: [PATCH v6 0/4] admin: Introduce legacy registers access using AQ

SGkgTWljaGFlbCwNCg0KPiBGcm9tOiBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+DQo+
IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMTMsIDIwMjMgMTozMCBQTQ0KPiANCj4gVGhpcyBzaG9ydCBz
ZXJpZXMgaW50cm9kdWNlcyBsZWdhY3kgcmVnaXN0ZXJzIGFjY2VzcyBjb21tYW5kcyBmb3IgdGhl
IG93bmVyDQo+IGdyb3VwIG1lbWJlciBQQ0kgUEYgdG8gYWNjZXNzIHRoZSBsZWdhY3kgcmVnaXN0
ZXJzIG9mIHRoZSBtZW1iZXIgVkZzLg0KPiANCg0KWy4uXQ0KDQo+IEZpeGVzOiBodHRwczovL2dp
dGh1Yi5jb20vb2FzaXMtdGNzL3ZpcnRpby1zcGVjL2lzc3Vlcy8xNjcNCj4gU2lnbmVkLW9mZi1i
eTogUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPg0KPiANCj4gLS0tDQo+IGNoYW5nZWxv
ZzoNCj4gdjUtPnY2Og0KPiAtIGZpeGVkIHByZXZpb3VzIG1pc3NlZCBhYmJyZXZpYXRpb24gb2Yg
TENDIGFuZCBMRA0KPiAtIGFkZGVkIHRleHQgZm9yIHRoZSBQQ0kgY2FwYWJpbGl0eSBmb3IgdGhl
IGdyb3VwIG1lbWJlciBkZXZpY2UNCj4gdjQtPnY1Og0KPiAtIHNwbGl0IHBjaSB0cmFuc3BvcnQg
YW5kIGdlbmVyaWMgY29tbWFuZCBzZWN0aW9uIHRvIG5ldyBwYXRjaA0KPiAtIHJlbW92ZWQgbXVs
dGlwbGUgcmVmZXJlbmNlcyB0byB0aGUgVkYNCj4gLSB3cml0dGVuIHRoZSBkZXNjcmlwdGlvbiBv
ZiB0aGUgY29tbWFuZCBhcyBnZW5lcmljIHdpdGggbWVtYmVyDQo+ICAgYW5kIGdyb3VwIGRldmlj
ZSB0ZXJtaW5vbG9neQ0KPiAtIHJlZmxlY3RlZCBtYW55IHNlY3Rpb24gbmFtZXMgdG8gcmVtb3Zl
IFZGDQo+IC0gc3BsaXQgZnJvbSBwY2kgdHJhbnNwb3J0IHNwZWNpZmljIHBhdGNoDQo+IC0gc3Bs
aXQgY29uZm9ybWFuY2UgdG8gdHJhbnNwb3J0IGFuZCBnZW5lcmljIHNlY3Rpb25zDQo+IC0gd3Jp
dHRlbiB0aGUgZGVzY3JpcHRpb24gb2YgdGhlIGNvbW1hbmQgYXMgZ2VuZXJpYyB3aXRoIG1lbWJl
cg0KPiAgIGFuZCBncm91cCBkZXZpY2UgdGVybWlub2xvZ3kNCj4gLSByZWZsZWN0ZWQgbWFueSBz
ZWN0aW9uIG5hbWVzIHRvIHJlbW92ZSBWRg0KPiAtIHJlbmFtZSBmaWVsZHMgZnJvbSByZWdpc3Rl
ciB0byByZWdpb24NCj4gLSBhdm9pZGVkIGFiYnJldmlhdGlvbiBmb3IgbGVnYWN5LCBkZXZpY2Ug
YW5kIGNvbmZpZw0KDQpEbyB5b3UgaGF2ZSBhbnkgZnVydGhlciBjb21tZW50cz8NCkkgd291bGQg
bGlrZSB0byByYWlzZSBmb3IgdGhlIHZvdGUgbm93IGFzIHRoaXMgaXMgaW4gb3ZlbiBmb3Igc2V2
ZXJhbCBtb250aHMgbm93IGFuZCB1c2VycyBuZWVkIHRoaXMgaW4gMS4zIHNwZWMuDQpJZiB0aGVy
ZSBhcmUgYW55IGVkaXRvcmlhbCBmaXhlcywgSSBjYW4gZml4IHRoZW0gbm93IHdpdGggdjcgb3Ig
DQppZiB0aGV5IGFyZSBzbWFsbCwgSSBjYW4gZml4IHRoZW0gZHVyaW5nIHRoZSB2b3Rpbmcgd2Fp
dCBwZXJpb2QgbGlrZSBob3cgd2UgY29tcGxldGVkIEFRIGZpeGVzLg0KUGxlYXNlIGxldCBtZSBr
bm93Lg0KDQo=

