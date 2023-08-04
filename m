Return-Path: <virtio-dev-return-13461-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6168AC04A6A
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 04:05:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5C51D29FEB
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 04:05:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4448A986845
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 04:05:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2BFE49866DD; Fri,  4 Aug 2023 04:05:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1100B9866DE;
	Fri,  4 Aug 2023 04:05:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UD6sxrXlAr/zO4+XGQZdhiaRldKQdH0MzFPCw4DNCNkHiwYUSLQIvdWj2HFwTsJGkk/sCJQbmnDiJxSXUGn3P3/+985by6W4UhVXafaCHTKnR5FKdjxPtj3WPV1pf7JNqcour7WtwZ9spzxqLVRVh8a6MFLKvOPC8cZL1CXVB5hzlTdwyiowkiOLAgRlY3v3P9/NJwXrHQ4KoJY90y/mDeENaFU+V5AVAJPCmpK5bWuf7JxnBwXZAyVN2xaAy1OIYteeCGPPYN1m2WjOjJ0nEGmvzl9nnBxII0F/cDHacEUsdi9sT9jvRH6Ml1d26bDfhU3h7ldGeysJp2OBVAj13w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPtwmPsGGDmZI6hj19UHOxSlKsG2bNHIJSQqkOxMNvw=;
 b=dWOrqaV/SrtFH/90iRCYpgTxCrTojqbsnRy0Dp/+KuxkbMMgn+gRLJMP75Ip6V+DZVVF7POA8ETgDVO6sNzBOSNTGwWIqDEcjUe8tPurMpc8lWlGczyjUplUoWU1HQbPPl1kVtdCRKW35sVYlPMyMHKgyDxi4IFz/5mv0e75wz1byXC7PXX56jEgLXthzHWW/UDs7v0Zq/tXE9O14mKSjjOjAgK7BqT2eRIVY4ma8xa4Rcbidir77wZRCX1443tgU8xSzmmi7PIXYt6t+gS7AyuEc05KtkQWAXIuUCrQLKtHLhchTi3ve2TeR7ldBqQtTtBKJej2zZRw5ViOARKVHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>
Thread-Topic: [RFC] virtio-net: support access and control the member devices
Thread-Index: AQHZxeT2Q5D2+syVdECqHrje6hzlHq/YUmCAgAEqKwCAAAkpMA==
Date: Fri, 4 Aug 2023 04:05:27 +0000
Message-ID:
 <PH0PR12MB5481EBFEB23938CDC765DA54DC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230803083150.46745-1-xuanzhuo@linux.alibaba.com>
 <20230803054333-mutt-send-email-mst@kernel.org>
 <CACGkMEsdM+bi_scj6kgo7FrRDNGwF-=37bT8tOC6DXg9fTuNRw@mail.gmail.com>
In-Reply-To:
 <CACGkMEsdM+bi_scj6kgo7FrRDNGwF-=37bT8tOC6DXg9fTuNRw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB6825:EE_
x-ms-office365-filtering-correlation-id: 6ac6a246-88e6-4bf5-8233-08db94a0099a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 n2VS49anExCopLuSKC5eBz0cf7QqBhwv0NJVNsj0AS24jbihUVYucmiDi6NfX6P3yfh1kuiNhQDiiUHSj3HpxykMckJBUXkay/WcukrEGa3C27XsHKvrrQGCWFEX7oe5PbSCH6HmNL4ZUihJHF99ovUvMDMK7nqe1oAvdTU2roUekuIgi3t6nHNrOO+sKEaI08R+ZCtYhrEUE+6JDJGrgm1RrPxDhbULgBPoaoOdMnbjGhSqV+l36cY/+Kru1f5+UaqllrpMBSq3ekWtqMkWiMeIJmE/E2BqfAdLD0H8uaCBEfERMGwOsnZlWlMfLem+1s4oa2/Hta1JEHoDbOks/H4PJRC+crmNFBn+2/+C5ew390asdn3xl8snGk8zVlWNFnVyVNmWBHlpRdOQjKzuXrDMLXMd6COoLAxnQd3XSsPabeCfPgoQXxIrGV5AfYww8bLhdV1EtKGBEm+1Eoqd5Q/DPTqUPCHIAsLJnY9m7TX0/Hlm7djbuILDZ3Tgyc8PJBU5wx9rIMB8WWyXgWzpFrP0dYC8hOfS7jDZZOmRpU/aFTIakVBPcWa+H2vpyaPh0QFQD4LUnnj+c4QlPEBYLBSuQ323p0nkaPdIyoNuWI+tRZ9NFR60DtEd4j5UlV/L
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(1800799003)(186006)(451199021)(4326008)(64756008)(66446008)(66556008)(66476007)(52536014)(66946007)(2906002)(76116006)(38100700002)(6506007)(122000001)(38070700005)(26005)(83380400001)(55016003)(110136005)(54906003)(86362001)(478600001)(33656002)(7696005)(71200400001)(9686003)(4744005)(41300700001)(8936002)(8676002)(5660300002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MmJKaUlWVEhCVG41QUovMUk5MUszYzMzVmRWVGV6TVB6anVpYk03WTNtejM5?=
 =?utf-8?B?UXlKVmxoWXkyM3BPQ3BENEJJYzBlSG5jVGFRQjNiNThCbHkzL0lRSUV2VnpV?=
 =?utf-8?B?UjArbGRlMGlHeUR6Y05pMWpodVQ0R3BhRm1HZFJGeDZUY2hyWTUySXFSVmRk?=
 =?utf-8?B?VVpyVFBVVzVkL2x4Um11OFVNK0QyK2dibUdtSzIzRXhWSk9ITVptOTM2em0v?=
 =?utf-8?B?Z09oUkJsak9OOUNpZ01hei94WE5UamtxYk1ZVGF3aE44YkptRWxPOGZocVhC?=
 =?utf-8?B?aDlOOTNWRmRIQ01KZ2kxNXpweEJlZ2FHaXl3djhhZnB1WE85bmJVUEVFNWxU?=
 =?utf-8?B?ekN4MXcxdjBJNWJGN3JFODlObWExNFgzcHFLZG5LV2FHbDVWZ081TEN4TFBT?=
 =?utf-8?B?UkZaMUVjaXBhQWZLRzFQN1Z6cllaQ0JRNWVkaUNMbXNOMGJXR2tPWWRlWHN6?=
 =?utf-8?B?Q3hhYlRqMlNkQmJmRUhqZmhtdG4rWldma2lyQ1BHRVdYWENRdUVSS1V2b3hs?=
 =?utf-8?B?bE55VG9rYnloMy9WWGU0czVlbE1zT1JORnZ4SUpsMUtwdHFjVnBIMlV4SnU5?=
 =?utf-8?B?VnhQK2pwbEh3V1lKU3hYTVJkMVYzbDhMZU9LRExQZk9JeDNCSktkdldXeEpj?=
 =?utf-8?B?bURSZVdleVBMelBMZ2FIMzd1cndDa1ljSXVYZlJHbjZkZWNGUzRzU0dHZWw5?=
 =?utf-8?B?bFR2a1NMY1JtUU5GakZ5WDdQV0dkMkl4amIwWDN5OFgyeDhCVDBlWFhhSUFJ?=
 =?utf-8?B?Q21ONUhTUWxHdGRWUCtnMWMzaG9wMHR1cWZkNjdGOEhmRXlkais4dUpBMHVB?=
 =?utf-8?B?UnRub213a2I3Q3c0ZE53UW5UUDArd3VsUzkyZHhmUURnVUpiL2dNTmZzZkl1?=
 =?utf-8?B?MVlpZ25nb0V1SWRoYW1VdEhWd3hIeVhjMEhML2xtaFdqcnFEWEY3WS91MU8x?=
 =?utf-8?B?US9LSlJRY2oxVTlmd0JGTGVtR29WbUorYWpwa293QkRMb1RmL2FBUDRhZjJI?=
 =?utf-8?B?OE5sdkI3ZGFNSDdQM3BCczRQK2RjVGthRWpKdERVenlyR1RhVHZ2U2JDcFlv?=
 =?utf-8?B?RkJzSkV0YlpEQXIzNEVwbU5yNVlIZUhaQmc0RHNhWS9BVW1Vb3ZvM0crMmRm?=
 =?utf-8?B?WklzSmJtNHFjaisrZWdBOGhMOFhqVUtJSXUxNkZnQVA1U0Jldzl0bEpuMGpW?=
 =?utf-8?B?MkUveCtmcnFVTkZvZUVWek9IWUdOdEtSYXE3M2doKzlwT3BrM0FlbWlPenVO?=
 =?utf-8?B?ek5kRnczL0NSL3l6SXdPQjBMbkc0eW1kakY0Y3RFcHo0bEh6dGxMQVJaZWNB?=
 =?utf-8?B?ci9FRHpOQVdSdjlTWEIzTHVTMWRBUFJ1d3VLNFN1UHlqcFZYWDg2THBXMXFq?=
 =?utf-8?B?VjcwWU50SDJGQUdrQ2doMFZrV0NJVmNGanVCaGRLenpFSHVQMDBRUzlWSHcr?=
 =?utf-8?B?RUFSd1htUjBWSUhNQk5FcTcyZ21ITW9QaVorME1CM20xUk1JaWNXRHErTGRT?=
 =?utf-8?B?WXlnOXpkNWlTRHA5TTd6NDNFNW56N3Jub3RpUlBPV05WMFgwNUczUTR5L3NH?=
 =?utf-8?B?VG5HWGt6b2VrTnRVejlwaG1RTHZMeFN3WjFvQXdiWFVIU0U0OEt1MTVvTmdV?=
 =?utf-8?B?WFE0UGtUNnRNSHdJZENKaDZtU1dvZ29saG5MaGxkU0NhTElvZEFnVHltNkZl?=
 =?utf-8?B?a1VFMDJaTlZadUR3dkZOZ1RzUmtaMVBPQ1p5czNUS05VVnlmZ05pR05McDQv?=
 =?utf-8?B?NUZwSWE4Qks3OXQ4YmoxNFo3MUx0aFh1Z1labUR2dUhrbnF4UW5kdXkxeTYy?=
 =?utf-8?B?cHRQWWpBc2VpK2N0eERHUGZvUHFwTnQ0ZTZoK2JPK3RDRWtXNzRPWm1RM0Qr?=
 =?utf-8?B?QzkrWG5wT2U4K0UrSlVpbXZQWFVpamh3QzE0azJBLzhuNmJ4azR1OGRuWFYv?=
 =?utf-8?B?OFRLNXdoZjlVZ0h2RWNlb0lBS2VrMkRyb2taOWRYK3Q2LzgvWTlBZVVlekRR?=
 =?utf-8?B?R0ttenIyeFNwSU50cUNrcElyd0h2a2tFMEtZamlUUTBDaWdPbHlqT2orSlZY?=
 =?utf-8?B?ZVE3ZmRneENWZzJ6Tk1KdzRnMDBLK05OUjMrekNHRS8yVzJ3aEVWN3FHMjc2?=
 =?utf-8?Q?uGl0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac6a246-88e6-4bf5-8233-08db94a0099a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 04:05:27.9542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w9gNvM9+ojehLj0xi289T0vQxdOislrrframR9hz7cj6NuyyXa5LOzdBwNbwcV/PWZwid1o2rw6Do04M45/NKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6825
Subject: [virtio-dev] RE: [RFC] virtio-net: support access and control the member devices

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogRnJp
ZGF5LCBBdWd1c3QgNCwgMjAyMyA5OjAyIEFNDQoNCj4gSSB0aGluayB3ZSBwcm9iYWJseSBuZWVk
IHNvbWUgc3BsaXQgaGVyZS4NCj4gDQo+IEUuZyB0aGUgZmllbGRzIGJlbG9uZ2luZyB0byBjb25m
aWd1cmF0aW9uIHNwYWNlIG1pZ2h0IGdvIHdpdGggYSBtb3JlIGdlbmVyYWwNCj4gaW50ZXJmYWNl
IGxpa2UgYWRtaW4gY29tbWFuZC9xdWV1ZS4NCj4gDQo+IFRoZSBuZXQgc3BlY2lmaWMgb25lcyBu
ZWVkIHRvIGdvIHRocm91Z2ggYSBuZXQgc3BlY2lmaWMgaW50ZXJmYWNlLg0KPiAoY3ZxIG9mIFBG
IG9yIHJlcHMpDQoNCkkgZG9u4oCZdCBzZWUgdGhlIG5lZWQgb2Ygc3VjaCBzcGxpdC4NCldoeSBk
byB5b3UgdGhpbmsgdGhhdD8NCg==

