Return-Path: <virtio-dev-return-12690-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F21CC77B7D
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 15:31:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7524026A32
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 15:31:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 56C8F986520
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 15:31:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 42BC09864EE; Mon, 15 May 2023 15:31:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 307BD986509;
	Mon, 15 May 2023 15:31:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmCB1hPFAGqyZ3hR19i46f2cXon68nmJIzIKodRnYPqnofQyW5XZHYuvIB1iJsVf4NO7KQcoH8Q2DqE5xOf+xYZnyRpM3yqZ2TmbdTcT2BCbiiBhuDuHNnSmWp3gqvF90EZ57BeERJqz2l2/0oPmQVGqMZ4YEnZJFaIH9BFv3kdt44IcRSeaWd+phCQUVR5nPHeRxF3ziMG3tcwwXsxnz0f3TLmV0S4i7gGqSNJIomRnJp1aDHzjiLYiPNBozz6/P5cFoZIli8tUkC7CB07lMZTyyaWLVNK6aJL3XRnaluCIk1FU/CRk/FB/XrynYS+4eXAUeC1BIkk5TUBvZMlZ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/lj5kHkXeMd4m4lQy9eGhX3p5AfVHKyp8Q4rET4G74=;
 b=HeBPSdhBPkJYtQGxoHLssCht0fK3HGxHxqBhWvVX0aS0U91PwuoihrxGfBIzfBbtkDuRYTDw83I4Y/zceUq9GOGQBL2uOJfwiv2dHLRCH6RPZTNfTbJiQl78oTbDcQ7nXMWtdjBOA3DE2Es42ifOd+YKI82z3EW9AjE5xM4K3BWYEFZhZQwNkIlBHe/RSNGnmgz6+8TpDj6oTi408axe6yIJOatcpQg6qle/wQdmKhLSqaib/6QlCUKx4bGJAGNsSxo6ey05mNtXUjiL+Eg6oY2VJK0vy76Lb3QQP8ddDW09zjn7XD3BzqZLI0mUvXu78mQrqQUnWLlBcoc07nE2NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ
Thread-Index:
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIADYnEAgACpnQCAAAFGAIAAENkwgAA311CAALAXAIAAZAWAgAXHc4CAAKnusA==
Date: Mon, 15 May 2023 15:31:41 +0000
Message-ID:
 <PH0PR12MB54815939DA349753648921ABDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
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
 <20230511085519-mutt-send-email-mst@kernel.org>
 <eb69906c-818b-a1ee-3317-262e159785e0@redhat.com>
In-Reply-To: <eb69906c-818b-a1ee-3317-262e159785e0@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS7PR12MB5744:EE_
x-ms-office365-filtering-correlation-id: 20652097-c595-45ec-6fe0-08db55597b3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5Ahe9kNP1+393lmVEyugyk6joTRIETJCv84B/zp0Jl0vGzCYz8N6+EN7gcIUzMojuw44lrjtZt4bCt4ksRCOG9Q6uKNH9PG35tiRo2HbleFxpaItJW2haZB/+OtxBn5cbD7e95RPwOjJP4k8rGQIMK8njFpLjKlzlljE+AFZOc9/p+CIZCdbARe8KxU64TYk6d1fwHfoHCoYlfJ91Y0JLoZj6in6vYq/QqSY2vMg+yWFLjLgmU2ItbIbi2xaL3HOvbG7/oGa4pR1F+u0yXJrKK1facZTbUXY5E/NUdXDLbU69l3XLJObVoaqDS+X8keZS6ut1VC0DnvElufX0/ZIo4paJCcgs5n3I1RswNyd807tvbefJqcnnKwDICsT8mGwU3sf6jNyxCJtfl9j+Fsz3buZLoPfRwpbI+Te9s3IxAy0GasjObAw0sbi+KjV9DT71MCFgeEaqV5CimzBX9DhURyt+2rit+wLKUq7TBTE/AusxwH24Zm+rTMFd/zCazUWxlOlN9xb6DOQNCPLiM7jR6hV7Co43KfOhKYsBaZYCaZRU8sPFNmemE67nwT2hty0zakv/IfPsoAl3A3Uz+0y0+y3oaoh5022heBaC9yJ/1Q7UH/4o2bzBppiZLcjGIU6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(83380400001)(7696005)(71200400001)(478600001)(54906003)(110136005)(9686003)(6506007)(186003)(107886003)(33656002)(2906002)(4326008)(38100700002)(64756008)(122000001)(38070700005)(76116006)(66476007)(66446008)(66556008)(41300700001)(66946007)(8936002)(8676002)(52536014)(5660300002)(55016003)(86362001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Qkx3OU45RkNiNWlMRko3dGZLMmlDbjN1RHBsa2t2RysyRVA1ZVkyVmZFR25U?=
 =?utf-8?B?ODJLaWRkb2dlUUJwSjl5dkRXQmNqc3Zha0s1Q3VkWFpacExMWUprUFU4eVo4?=
 =?utf-8?B?blNTWC9laGwwby81OVY1ZjlydzArODRsZ1l4amVhWTRJN1BKMU54Y096ZjNr?=
 =?utf-8?B?MUhBTm4zNWVZczY3Qm9IN0t3SEl4TlU0U1N5UUhvWGthOU1EOG1VcEVYWHZZ?=
 =?utf-8?B?RVBmODNJUFhzeXR4T21OdUl3MVJwSVZwekJTSEo4Zmsxd3Uya0RuVk00YlVh?=
 =?utf-8?B?UHF2NzRaeDVBRTlQMElQM2NuWTVKZ01VWFArei9LL3pTM3JuZEJjbGZrVlQy?=
 =?utf-8?B?TEZyQUxQTEh0b3lERjNYMnhQM2RUalVNMjBGWWhoNmY5TngyUlFjdTBiVnpk?=
 =?utf-8?B?UVF2NVg4K2dMN1c5RmZvclpyUFVXM0pHQkE5UkVqa09aWWNVdEszSzNXclFu?=
 =?utf-8?B?WVBsenlWMkZ1cWFLQWNsVkRlMjhvVHlnTkhEckFENGtYWHhYUEhMck9mdEpm?=
 =?utf-8?B?NzhrY0JISlpqVWhMcWNaOVV4QU9sejdZdjc2VmxxTjNuOFUrSHpaWDVxcWYz?=
 =?utf-8?B?QzRJdFhDVjdxZC9GTUFoem1Vc1hLeFRvNk1XY3pBeGsvd3lWQjBTTlNrUkxY?=
 =?utf-8?B?eUxMbkllcnAxQTRpakpsVFVsQlJ3RndXMW92T0J4Um80Q2h4Yy9ra2kxdnJu?=
 =?utf-8?B?L2crQjh2c0szaExDeTNpUEs4Q0ZLWUI4bnR1dDNIZ0NBNGJFYmxNVHRrelFX?=
 =?utf-8?B?aTBSQ3E3ZHlXMEllaE1PMTdmQmd3dUtocmloY2lBSzluUW9YRVJuZ3dKQWw3?=
 =?utf-8?B?RExsMnMzVUQ4Z3Fia24yYXhNSVg4ald5eTZ4VVpGKzhsdmozYjc3NGR5d3ox?=
 =?utf-8?B?NEtPa24zT000M2JZQWErTUZEWHpaazMzL1RRMmdBcGQrSmVmSU9qaktSb3lN?=
 =?utf-8?B?OGZMVmc3cTRiOU0rek1qcnNlNjQ2S2tnTDRMNFF3VDIzdlFDT1BwQzBQbVJm?=
 =?utf-8?B?Vll3dGpKSkdKMjdZa2ZBTHJ3aXo3R2xxOXUzUU0xZnNLdFp2N2M1am4vMjgy?=
 =?utf-8?B?UGRwaDNuVTJYcjRWREl3Rk50UC9FdzMra28zUHYzR1JvODBXejBNN3lwSXdB?=
 =?utf-8?B?WG4vdHErREVPVXlDck9vb0RLZGJUdDRmZUdkRjJ5VFFCUVIrNGRNeDg4V1Ev?=
 =?utf-8?B?T3k2QjFVQ2dpRHhEeG5ReVh4d0ZFR042OTVTR20wNElsclo4K1hlZ0xMbGgw?=
 =?utf-8?B?NUs5YThvRFpNZ1NnTGRJYjhqeXVJbk42aUFpZVpoaytXdWQwQnZBOVdZbVhQ?=
 =?utf-8?B?L1UwSmJBNzZBWWNsWTFHQzZBYzA3MlpHUzV4WEFkVld1ZU9oV1BxMEhVZUUx?=
 =?utf-8?B?aXhiQkFnRFRlR1FJcE5WMTh2SFU4bEMwYnMvYnl5RnY2SmZmbExoRWtwMDdm?=
 =?utf-8?B?VVZYZWxVQ0xEUHFkdlF1aW9YZElXRkpTbzVhNW5idDlaOFdzeks4MG9zZyts?=
 =?utf-8?B?RmtXQWJxQnJCN09TZVR0Y0xXcDVNS0ova0J2dXR3TnAzNS94ZEl5ZGlRSkVJ?=
 =?utf-8?B?WFdsUzBDZGtGL1R1YWo1b0UzK0lEaGZNMDJFWWQ2M2t6RnROdjh5ZHp6bUFF?=
 =?utf-8?B?MGRKRDM3NDJhV0s3NGhDV1NmUVZpc1loOTdCWXJjRDhpaW1Kb0tTNTFPWUFz?=
 =?utf-8?B?Uk5JRllYeFVKbjhBZlBYRysyamFZZ2RvRnZkNTNZMWt3NjF2ZUJMcWYxdDc1?=
 =?utf-8?B?ajVKQ2kzK2IxMXRLMHBkc2ltblNrZVJzZ2pYNDNrNi9EeDh1VzFQZW5qczJz?=
 =?utf-8?B?NGFyaHpTK2xBU0hxdVV0WTNNYnMvQlpkSUhXUWJBcjVUM01aVW9OeGtJVExj?=
 =?utf-8?B?V0g3cWRhUmRDeXNoc2lXTVMxcU1NaXhzR0R0TS9jS2hkT25qWllLejV3amxN?=
 =?utf-8?B?cklEcnZ0SVc0MlppQ3JEUTR0Tk1YR20reGNhcjZyZFFaSlBiVVBoNFAwalZT?=
 =?utf-8?B?MjRKR3lGR242d0cwYnZUWkhLVk5UTUQyT2Q1QzB6SmJsd0ZYUldWaUVWdkFG?=
 =?utf-8?B?TGJEWk95YUpWNUJQTkhic1BNR014MlRiMHdIY3g4dU1WZndkaFkvcmFTK3pV?=
 =?utf-8?B?MkJlRDV5UTQ1UHRoTm5HSGY5VGUxeVVyYnBIK0hNaExFYWo4ZFBIc28xYUJD?=
 =?utf-8?Q?yErbBPdOQpSsnHO0hTlK2Nw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20652097-c595-45ec-6fe0-08db55597b3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 15:31:41.0508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /cFSX73yE9ABIXnJEQEZkXPOb/p0G3TxbYeg/jXiz8Y/VgCaAKQ5jSaT/0U42y/w1DQBGTDQ/8qdrFOoagMghQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744
Subject: [virtio-dev] RE: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IE1vbmRh
eSwgTWF5IDE1LCAyMDIzIDE6MjAgQU0NCg0KPiANCj4gUmlnaHQsIGJ1dCBhcyBkaXNjdXNzZWQs
IGEgcG9zc2libGUgdXNlciBpcyB0aGUgU0lPViB0cmFuc2l0aW9uYWwgZGV2aWNlIHZpYQ0KPiB0
cmFuc3BvcnQgdmlydHF1ZXVlcy4NCj4gDQo+IA0KPiA+IHRyYW5zcG9ydCB2cSBtaWdodCwgYnV0
IEkgYW0gd29ycmllZCB3ZSdsbCBoYXZlIHRvIHNwZW5kIGV4dHJhDQo+ID4gd29yayBjbGFyaWZ5
aW5nIGl0J3MgYSBsZWdhY3kgaW50ZXJmYWNlLiBGb3IgZXhhbXBsZSB3ZSB3aWxsDQo+ID4gaGF2
ZSB0byBleHBsYWluIHRoYXQgb25seSAzMiBiaXRzIG9mIGZlYXR1cmVzIG11c3QgYmUgdXNlZC4N
Cj4gPiBGb2N1c2luZyBtb3JlIGVmZm9ydCBvbiB0cmFuc3BvcnQgdnEgaXMgYXR0cmFjdGl2ZSB0
aG91Z2ggLi4uDQo+ID4gSXQgaXMgd29ydGggZXhhbWluaW5nIHRoaXMgb3B0aW9uIGluIG1vcmUg
ZGVwdGguDQo+ID4gRGlkIHlvdT8NCj4gDQo+IA0KPiBNeSB1bmRlcnN0YW5kaW5nIGlzLCBmb3Ig
YW55IGNhc2UsIHdlIG5lZWQgc3VjaCBjbGFyaWZpY2F0aW9ucy4gV2hhdA0KPiBQYXJhdiBwcm9w
b3NlZCBoZXJlIGlzIG5vdCB0aGUgYWNjZXNzIHRvIHRoZSBhY3R1YWwgcmVnaXN0ZXJzIGJ1dCBz
dGljaw0KPiB0byB0aGUgc2VtYW50aWMgb2YgdGhvc2UgcmVnaXN0ZXJzLiBJIHRoaW5rIHdlIG11
c3Qgc2F5IGhpZ2ggMzJiaXRzIG9mDQo+IHRoZSBmZWF0dXJlcyBtdXN0IGJlIGFzc3VtZWQgdG8g
YmUgMC4NCj4gDQpJIGFtIGF2b2lkZWQgZHVwbGljYXRpbmcgYW55dGhpbmcgdGhhdCBpcyBhbHJl
YWR5IHdyaXR0ZW4gZm9yIHRoZSBQQ0kgaW50ZXJmYWNlLg0KSW4gbGVnYWN5IGludGVyZmFjZSBz
ZWN0aW9uIG9mIFBDSSwgd2UgYWxyZWFkeSBoYXZlOg0KDQoiTm90ZSB0aGF0IG9ubHkgRmVhdHVy
ZSBCaXRzIDAgdG8gMzEgYXJlIGFjY2Vzc2libGUgdGhyb3VnaCB0aGUgTGVnYWN5IEludGVyZmFj
ZSIuDQpJZiBNTUlPIGlzIG1pc3Npbmcgc3VjaCBsaW5lIGluIGV4aXN0aW5nIGludGVyZmFjZSwg
aXQgaXMgYmV0dGVyIHRvIGJlIGFkZGVkIHRoZXJlLg0KSXQgaXMgbm90IHNjb3BlIG9mIHRoaXMg
cGF0Y2guDQo=

