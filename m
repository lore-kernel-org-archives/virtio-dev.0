Return-Path: <virtio-dev-return-12899-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56DEC7EE2E
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 18:55:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D77622CAFD
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 18:55:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D140398668D
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 18:55:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C259B986681; Thu,  8 Jun 2023 18:55:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AD7E8986682;
	Thu,  8 Jun 2023 18:55:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ivm6jVZtNGT/6+iSJT0S5YntMnQxXMBXlx30szAVVMVTnsLAvH0hd9ONn8dCZmg9Jofd5KhYN1hoapOMPTgYPVjTtkYyp1oFcTQDZ6IZGBUk2hSj5P4+9tWp425Q/CVtTSQB2eInA9mvWClxQZ2qKf4P6WeHOq7GcP9VUIoYjVg6PTugNxvhg/ZPvcWpEOKnufzETk7KpGV3n2jGo8xizGwGJtRDeLhDxyApBXNgcycSPmwKvpRaGZPzldOUyT3cNoobcwFOxQ6JCkc3nJTbVf5Oh3KRBALJi8Sj4Mfx8yOMdEzDuN/hFNJ/AXnJ2wW1rjcaqDoFJdVm9stepkaUyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssocIzzDurjwcKkTE7piAr6A496n52lURObIHYMoyYM=;
 b=oKjnQ0ue0+HgSgVhS/97KQqG9CrcKrbCJgZAALdJpKhslo4r6JRu8FJy0KiLck7bmTJs6HBYDM0gqFAS27yyxBicHEBXBzCodOYWoBcsX2Gaxj1EVAKAWMWhzSNLfZQG9McxUk6zFR8XuHYS3UMkKAvFU0DmDl9c7gG8MiFIQkFUCeo7Eb97VcjOApDQpR3aw8+3HXM0Q8T3Fp1f6EsyiEkcRMepo0m87B1XAnc4pF5mJG/EVdXAZHzZLDasNqSg0Z5REphZjg/2WOLHAMiCN/4EMr31u822F5+hM5GkxiwKFi8/Ep+qv7QcuMKuyrZTfykrdo7z6sBYF5ZHM8ZL/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v3 2/3] transport-pci: Introduce legacy registers access
 commands
Thread-Index: AQHZlZHrjhTPPTQ0ZUaNTBTq19TtJ6+BRI4AgAAFc+A=
Date: Thu, 8 Jun 2023 18:55:29 +0000
Message-ID:
 <PH0PR12MB54818BA9BDC5EAF4FA8388E4DC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230602203604.627661-1-parav@nvidia.com>
 <20230602203604.627661-3-parav@nvidia.com>
 <20230608143135-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230608143135-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB5963:EE_
x-ms-office365-filtering-correlation-id: 64277e3f-175f-46cc-79e8-08db6851edad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GpUdRQlvOqnxVESCuYFKwATlFLoOz58IhJEFzDnVz09d4WftTNp9AxZaQK/xmvYHgryItNo8xpJsjhGnBRog7BdnpV58Yl7xtQsufJJ1SyyDl2qkiR5WqkJMCXLrbofd+0rEn3RyMDOVGuO9lqYuTni9H+7P92YS7qbuQ+PbeFS+IEcTJJnY8Sda8SwlbcoPf+95D3Kd0mFN4pyo6J7sHAeJOIS8+1/9p46WKnt9/kRRmwxypK9jq8BWjTsZ+eoBCF/DqfNJC2aG4yrfvURcaIHDrOQhcs6UXujE2mT2LbnWbtxirgFKGi3X9eT163tdz3tvaCP+1Jdf4Vf9oW12wlXDKA4wI0Fx9SjMatdFSyW9NcIpmJ9GdfSpVuSph4ZJr3QWI8vvxNyn3uJpEyOb0L/YfTOUXYYl/I7MvWUkKNetU/y8VMBxLE2uey4q+tUHcfbpSJQrsGmWRHaOGmrGzvv8apZ8vBZWVUNHg57EzAPUTu+Ol9Hj/ivfE9eoBFHPPREVR4V17bU0fRzs79ERkGAwzl0A2E4VXi6jHus7H1ILgy7fb0cJpoaAPjJVU/HhCB65rHvx/pIsJmrhyaWR6Qb0T8LdDqlNb/2MOQWoY8lNam4puvcyUFAF92sZAijc
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199021)(66946007)(66476007)(64756008)(76116006)(316002)(66446008)(107886003)(71200400001)(54906003)(6916009)(4326008)(66556008)(478600001)(86362001)(33656002)(38070700005)(83380400001)(26005)(6506007)(9686003)(186003)(5660300002)(41300700001)(8676002)(52536014)(8936002)(4744005)(2906002)(55016003)(7696005)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TnZrbndIbko0YlBOODRUZUdTMHNSeUdpYlVzT0IyVkFNanRsbDJHc1pLQlFL?=
 =?utf-8?B?U2QvSDF1cFAwVDYxR1lYS3ExT0l4dXd3Q09Dbk81ZFJBMzdjVDFFaEZ1TEpi?=
 =?utf-8?B?S0lvUEpudUVJK3JkYWFPcUhRSjNidENrRDNiTkQ4RU00ckYzSU9oQngzVmJz?=
 =?utf-8?B?M3l2SkhGWW51NmFkMXQzaTlkbGpJZmE3Y0hyMXM2eW1aT0dWVnRJbW44cjR0?=
 =?utf-8?B?S1BtMEkwTi8wbFVlZFF4MmxTR3h4QzlUZHJBOGpCMU9CcUcyYVc2ajFyZXcw?=
 =?utf-8?B?ZStNODBpS0l3eHV1UFFpMjJkS2hmTmEzRGRhYWpBK2k3eTEyT1hEY2FqcCtr?=
 =?utf-8?B?QjFuK1VlZWJDWDdsemFxT0h5Z3ZYYlY1bU03U2V2cmZubDVEWmpQTWRteGkr?=
 =?utf-8?B?S2hIZGlEU2lLc2pLZDRrQXh2NGxkZk5BN2I0WnVWclQ2Ni9TeXlleWVhTFlM?=
 =?utf-8?B?Y2JwTVpTdjRoc0xOM29VUHlFREN5V2w4TEpCa00vM2VpRXJlZXo4dm9UYXlL?=
 =?utf-8?B?SFU0aW4yRU4rZENPWkFmU1VXZmd0bEVUc2N1ZkV2REFveVp4Nmd5cDJKODFZ?=
 =?utf-8?B?QjhxQThGdTlZWEF0clhGQUpoZnNLaSthV1F3TEVLbndRVmRoMloreVhDQytI?=
 =?utf-8?B?Tk1TWFc3dTlseHlPbUliYVRhdEh0Wk84aEErU3l2Ykk2NWdocjZwN3NLaUVU?=
 =?utf-8?B?b244Y3BYUVRaUFFlNnFGeGlGZ0pYdEh0VW5kRUtMTlBmNEVwcjJhdUZJV1FQ?=
 =?utf-8?B?SlRVYXVWZ1kybkhPZW5PcFhZMkRqTVhMdE9aMC9XQll2VURITGRlZzAxZWg3?=
 =?utf-8?B?OUNlbzRmRTQ3Ri81MVhyK1dydkdJNUxsU09hMHMxcHc5TTU5Vm9hNTVjay95?=
 =?utf-8?B?dzMyeFVkUzB6UmJWc3RUOFBGUGltOSsvOUwxZlR4MmorTlpKQnNvMEhERzVM?=
 =?utf-8?B?TmsySkdJQjZoVFU3NzQvQzBSVzYwL2xkTU9uU21kdllRdnFWQWFXYk1WZmt3?=
 =?utf-8?B?MmtiWFJTT0tWYXd6TGpUNXRNSk5BdHV4eGtrWktxa2VQdTlkZTI3Z0tuS0tr?=
 =?utf-8?B?WWNxL2J4VkpHMXAzL0svVW50M0hqK3ZlYXM2SFJmQjJSNGZVOHVYdGJ4Zkt4?=
 =?utf-8?B?aEorV0hGTEV2T2VPdzNFL1lKZkQxS1VWSEVQUU5PakpsdW5yY2w3N1ZheFoy?=
 =?utf-8?B?SVdIL3dEVEJNeTBzOENUanBoL3hrTURhemd0Z1h4dDVQcCtxT2twOHhNWWww?=
 =?utf-8?B?TjZEVVJMT0tESGdWUm9Zc2NVU09yc2RaN0lnRlc1aXh0dFpvWmo5MlRHRTg1?=
 =?utf-8?B?a3hTZFNEamlIaWFlWVQ4L1VlQ1V2WDMreXFaRko5ODVpcU40UmY5dXJWSmc4?=
 =?utf-8?B?MWY1dkRkb1FDZk5za2lqTWJKcE0rVUdQYlI4eFhvSUVIT0U5d3JnYXZvNXRU?=
 =?utf-8?B?Q3pKYUN1dkxFaGxyejh1T2tMbncwN2k5V2tIRnQrRzg4Q3A0VUEvWnFxbnha?=
 =?utf-8?B?anlsUy96TS9aL0lNbk5aNWR0cERoZmxDRVkzTHBYS1B5UU1zWXVaK0ZUK2Rs?=
 =?utf-8?B?Z2dxcXZPUUozWW92SnQ4RE5MQm9YN2x1cWhJZlo3U0M4NmoxRFM0R1M3aS85?=
 =?utf-8?B?TEdZRHVBYmFyUGtSN3EwZVlUc3ZYUUpaczcwbzVWbHF1NnB5Mko3cmpwcU90?=
 =?utf-8?B?N0l0YjhkNWFhN3d1Z3Bhc1VwdnV4R2tld1prOThpcjdLYVFYblJwQSs4STZT?=
 =?utf-8?B?ZjE2ZzRHZ01Vdm54dWU1VnoyZm5oWHRNc1lKYjg1eUtWVGtyM00xMTF6UzR3?=
 =?utf-8?B?OG93elZnai8ySlpvdXBjUm4zMXgzeC9WcXNtQ0t5RkxyTTYzN1RNb3VBOW9X?=
 =?utf-8?B?cHRMS29rb2ZncnVEVzB2Q0NLVnhCTnNrTzZqU2VhMlpiMWlpRExPT3pMN3dY?=
 =?utf-8?B?SitxdGtwZWFvOTlzMGRBTGU4RGFwcm9kaU1HYkZzSFpSSllVa3NxeUdzZlNS?=
 =?utf-8?B?Q2w5d2lOcFlKZTdyR0R3aWRudE9UYUp4bXpuQXpTNGw2U0JPZ21vcWprT3pB?=
 =?utf-8?B?TkJWOEdqVVY2ZjlzQXp2LzhNRllnZ0RDbzZ2MHllYzRCV1N6YmR4eWNwZnFG?=
 =?utf-8?Q?w6Ck=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64277e3f-175f-46cc-79e8-08db6851edad
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 18:55:29.1758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: geSq8R8VycN5TahpifN2Gl0cOGdieBMi2caZTrhy6zl3iU66QIl4eUC2KKpfUhi6+nJ3frWYEdhLz9QqCDDxGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
Subject: [virtio-dev] RE: [PATCH v3 2/3] transport-pci: Introduce legacy registers access
 commands

DQo+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRo
dXJzZGF5LCBKdW5lIDgsIDIwMjMgMjozNCBQTQ0KDQo+ID4gKzB4MDAwMyAmIFZJUlRJT19BRE1J
Tl9DTURfTENDX1JFR19SRUFEICYgUmVhZCBsZWdhY3kgY29tbW9uDQo+IGNvbmZpZ3VyYXRpb24g
cmVnaXN0ZXJzIG9mIGEgbWVtYmVyIGRldmljZSAgICBcXA0KPiA+ICtcaGxpbmUNCj4gPiArMHgw
MDA0ICYgVklSVElPX0FETUlOX0NNRF9MRF9SRUdfV1JJVEUgJiBXcml0ZSBsZWdhY3kgZGV2aWNl
DQo+IHJlZ2lzdGVycyBvZiBhIG1lbWJlciBkZXZpY2UgICAgXFwNCj4gPiArXGhsaW5lDQo+ID4g
KzB4MDAwNSAmIFZJUlRJT19BRE1JTl9DTURfTERfUkVHX1JFQUQgJiBSZWFkIGxlZ2FjeSBkZXZp
Y2UNCj4gcmVnaXN0ZXJzIG9mIGEgbWVtYmVyIGRldmljZSAgICBcXA0KPiA+ICtcaGxpbmUNCj4g
PiArMHgwMDA2ICYgVklSVElPX0FETUlOX0NNRF9MUV9OT1RJRllfUVVFUlkgJiBSZWFkIHRoZSBx
dWV1ZQ0KPiA+ICtub3RpZmljYXRpb24gb2Zmc2V0IGZvciBsZWdhY3kgaW50ZXJmYWNlIFxcIFxo
bGluZQ0KPiANCj4gQ291bGQgeW91IGF2b2lkIHN1Y2ggZHJhc3RpYyBhYmJyZXZpYXRpb24gaW4g
Y29tbWFuZCBuYW1lcz8NCj4gU3RhbmRhcmQgdGhpbmdzIGxpa2UgQ01ELENGRyBhcmUgb2ssIGJ1
dCBMQ0MvTEQgd2lsbCBub3QgcmluZyBhbnkgYmVsbHMgZm9yDQo+IGFueW9uZSwgZXhjZXB0IG1h
eWJlIGNvbmZ1c2luZ2x5IG1ha2Ugb25lIHRoaW5rIG9mICJDIENvbXBpbGVyIiBhbmQgIkxpbmsN
Cj4gZURpdG9yIi4NCj4gTGV0J3MganVzdCBMRUdBQ1lfQ09NTU9OX0NGRy9MRUdBQ1lfREVWSUNF
X0NGRz8NCj4gDQpJdCBsb29rZWQgdG9vIGxvbmcgYmVmb3JlIGFiYnJldmlhdGluZyBpdC4NCldp
bGwgY2hhbmdlLg0KDQpWSVJUSU9fQURNSU5fQ01EX0xFR0FDWV9DT01NT05fUkVHX1JFQUQgDQpW
SVJUSU9fQURNSU5fQ01EX0xFR0FDWV9ERVZfUkVHX1JFQUQNCg==

