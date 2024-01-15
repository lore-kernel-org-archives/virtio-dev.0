Return-Path: <virtio-dev-return-14234-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1B5C47258
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 09:09:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 19E3B60CEB
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 09:09:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 01A7C986511
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 09:09:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E234298403A; Mon, 15 Jan 2024 09:09:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D0113986367;
	Mon, 15 Jan 2024 09:09:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3xHffVenQ60RvpjlDdUR6ywdDRmtTVRnGowjqwB/LZCL9CMGXjiPzbhwpVwtD2Q4M6atul7WHpnWCyEL1iWVZs4ttdg5x+pf5i1mO1fHP6lw1S9RbyN40eVbfYfWqT9rakp2GD4kcEK+kPhGVkzSLH4s0fIoYnxIimelq/h7efKusI5XOBrcIPAoW860G07rJeN03c6yx34L6U6dDgf/uzvPv/2w8joNjLePgorA1+HODm96s3tiYEHfYB146UKTv49XgvaFA2mskN90bmOwoQeETmA1bmYKIFw17NrrTWeUtBJl5g1UXXcHkOwx/dQMvUa4hFdKFxfeTGBTfLAHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cLaYzKspfWgNaCb07FP7SNn4URWD1x2uIWuamn3ffc=;
 b=AFLuzKcXkIIjFxEt147h2Z8qqr3NKbkXES5XR351F4hJto+03fxFK1FsJoARfXvQNfrQEA9XIXuIOhy97maRXnqLmUzhfZNGdwViZEfG0AR+j3Td2qO6d7Uj2U1rkKEkQX6rrIMVI4TK3jONeISwF8VsEOFkf8QKV2MSV8fue91di2YGPQSbFJ0HMQKdfT4HwG2fh8RLgya48b0RAy0uub0/Nb36w7qnClzsA2LSMOwUrSRxFTYqcD00raFoMQjv3xjqnGIzRiJgZ1ot4g2nxd0MwHpnnwyenBMjMmWyZcYvoASPocf2HaxIJGPQJB16ZPtDJpJhAIfLXRS9r5bhfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Parav Pandit <parav@nvidia.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	David Airlie <airlied@redhat.com>, Gurchetan Singh
	<gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	=?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Robert
 Beckett <bob.beckett@collabora.com>, Mikhail Golubev-Ciuchea
	<Mikhail.Golubev-Ciuchea@opensynergy.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Huang,
 Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia" <Julia.Zhang@amd.com>,
	"Huang, Ray" <Ray.Huang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Thread-Topic: [virtio-comment] RE: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES
Thread-Index:
 AQHaA9HvmHelxVzMEkK9DIiJvUqDjbBW5OUAgAC5UoD//8WsgIAB4oYA//+CG4CAAI+hgIAAjVeAgAJwQAD//5FqAAAzXyGADyowGYD//4AlgIAAia6A//+C6oCAAItHgP//hKUAgAUWT4D//31GAAAQ5xwAABBKiAAAD6fOAAAuOxQAAEuTxoA=
Date: Mon, 15 Jan 2024 09:09:38 +0000
Message-ID:
 <BL1PR12MB58497CDB1A3AE937CAF24BCFE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20231021035111.650248-1-Jiqian.Chen@amd.com>
 <PH0PR12MB5481553C8461B7F1F047B5D3DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB58492CAC080A708809E434B0E76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481AD6A2E262A419FA2CBA8DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584943FA1C20BBF618EBB73AE76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481BB80679107D8E0167954DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584952204D1C8AD579F8A87CE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB548102E41B13AAB57C7321FCDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB5849F3E85F2661EB38128A67E76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481158BD79A17E1C49ACB6BDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB5849D8D396D00919482CB6D2E76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB548145B7409F2D58AC2F6D44DC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To:
 <PH0PR12MB548145B7409F2D58AC2F6D44DC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: IA1PR12MB7567.namprd12.prod.outlook.com
 (15.20.7181.004)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|LV2PR12MB5845:EE_
x-ms-office365-filtering-correlation-id: 5e328700-24b9-41c3-3263-08dc15a9b3c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XyjlGEPmxkNLnZc7l3dAruAC/ninmkn0DquYmCV83WxZ7dz1oSofJzS9E8OWiXqx2auYOysciHCsLr2WWxUWIWEMPCX7dlc2gPz1kLRvbNEN0B+PLxLXQjdjKYdoQfkByehSZ2AuGGfI36b4wQeqWkoDnpwGcyQiTo5GawYmx3VHqHcYfhBU4J589HgikIanHRe92ruWlOpQZgIIIJp1CEOv5DuHX9KNti0MBzpi9cSTcIKK/lXPvSoHs5TgdgvdTZ26nOKGpsfANAc8SpNF2c/X8knDJ1A72w8ODM42VobLWiwf1wMqSH7XZd8U6CoMgkWQr63wZUqnOrzY7CXUXR/1fZhF1cIKk0whBWCW8aJq11GIFFJR25v76dF5Jc4lgC8FN9J521nNg03JYY4we6w95zMvZwyLDXwY6h6ipZBemI4hdxOjsS69Tpvp2Sk7QYLRInh1x+36IwOGkaunqBoQTagTlQxtIhrvZGJhDjDQT4misKw8e/Pl1D7JbnxYiAaK9/HZNoMFPymbmrvuc+HIg81X5wpWeeRDYPbuxnhqkMVB6s7NCQFAPj3g2O+kQL0zMGePGbOozhVlEUZx/sdGwxwbYCSeQCorkQPDSiOz6nsWDugbLqxiwgyDXQ/M
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(136003)(396003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(5660300002)(7416002)(38100700002)(76116006)(33656002)(2906002)(9686003)(316002)(4326008)(8676002)(122000001)(66446008)(55016003)(8936002)(52536014)(66946007)(66476007)(66556008)(6916009)(64756008)(54906003)(6506007)(478600001)(7696005)(66899024)(53546011)(26005)(83380400001)(38070700009)(41300700001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1E2OEg3NW5jNG5OcStwN0lkaXo3YUlRQVBpZ0ZubG5nOWYwR3Q1VlN6elh6?=
 =?utf-8?B?Qk0wVkFzd1RBL01FQXlqNHZxWWZORitvYUF1VlR3NDRDUFY3b3NraGw4U3Ev?=
 =?utf-8?B?cTQ4TWYrcHZ4OEhhZ2FyQU9XSkU4bzdLbUE5d0V0eFpqYjArUDlrOUEvS2FT?=
 =?utf-8?B?VTRmR3ZzMlRad1lNM0NVcHdQaU5WcEgwdkEzNVYvSkRJb3l0R3NCcVNwT3d4?=
 =?utf-8?B?d0hBZHdGRVNCT2dJR05WMFJHYTJpL3BCdVpHWnlCK0JsRWxoTHErQ2xpWVNp?=
 =?utf-8?B?Y1JrRWM4Q0FMYm9NTTh6UnMrNnJYUXluZUJ3aTlvcVhnMmUzdmxTTzBmYlU0?=
 =?utf-8?B?d3RNZHgrVjNFaU9UQkFrcXpMQnRwSXQ5ZU40NzUyUE1MSjdyNE5JRHR5d05m?=
 =?utf-8?B?R1QrRk0rbWxHWGF2S1lOL0JmNFlRekN5cHA3MFFERzR1eTRZSTg4bnIrZ1Bo?=
 =?utf-8?B?WklMMmRuSWhJbjZyTzM0aXAxNXE0dmtxU1lWNEljdFg1RGRvZ0tEVHN6WUdq?=
 =?utf-8?B?ekJ6WEJHNk9RYWZoYzVMNVVENXUyWVoxVGkveGJnOXZIOFZoazNiZldSOGF5?=
 =?utf-8?B?b2ZGdmlURjNsaDMwenFkb1ZnTHhtY3dlNVJIaGZ2Y205MkVLUmZYbThjSVhO?=
 =?utf-8?B?RjdyTFc5ZWVISFBzbEdQZ2Nua1VnVnpFY3kyZE93UFZvNS8xVUEwVmtsZlR6?=
 =?utf-8?B?S2kyNFFabXh1Q01TODFDaFBFOG81YU9ySVJyQThXWjJ1TXJiZTYyUDZLNzZP?=
 =?utf-8?B?cWRWUmJDREx4dlU1SUF0RVVwZ0ZQeE1QVGpiOTJic2F0SVFrcmtuM0dCVW0y?=
 =?utf-8?B?R0tqSk5HNnlQV3dYWE8xUlBCWEN2NXdEbUtlWmxIVDk2VTB4MCswUWZnekI2?=
 =?utf-8?B?OFYvTkhJQXFscmdrZkVrRWJ6clM5RjRoRHZFQzNpRnBQenc2ZkluT1k5ZmE5?=
 =?utf-8?B?NDRYa2JLa1BiYkgvR3JzRklsbXNRN3F2bzlRa2xYMEtFdUQ4NXRyVmU0WTV3?=
 =?utf-8?B?blBlVWFkenZ5VzR4N1JIQXA0cDB6YWk1dlQvN1Y3UlVYaFNJM3BQdFRzVUZs?=
 =?utf-8?B?aGxuaVpOcHhzbUthemRUejkwcGx3WWJWbktXTzYzM2NobnR0UkJmVVRLZTVr?=
 =?utf-8?B?dlpqeitIaEpNZUptOXNYYUczdzVjL0FjOUkyQWJWYk81OUZ1NmxObUdWMVJT?=
 =?utf-8?B?U0pBUTltRS9JWkp6dWxNUHRxY3RacHMwOCt3SVBPc2NVZ3FDOEVmWXUydmF2?=
 =?utf-8?B?NHFZM29DY0s2ZnFCY29TbHBPbnl6QUxnaGQzcmk3Qm4zZm84MjVTaE1wbTdF?=
 =?utf-8?B?MUJUN3RXU3pZcE83MHFNeGVjQXdKVGhDY3ZiNmFYSExpcTZhaUh3L0hSRisz?=
 =?utf-8?B?cE5CdEVJQUVBR3RCWjdLcUtEOUJMeHVWNHNLazZPQXZZZFV3WUgvUDdCZGVm?=
 =?utf-8?B?ZDZhRWdNN0RGRU1oK0xaTlRZc3ZaV2tleSs4VDRoTUtqVUNaaEtOeXJCNDZ0?=
 =?utf-8?B?UEdyK2Ewa1hOT1JFd0JkdTZPWDYxalg2ODVreE15WWNuYlNjVEQvalVJMFFl?=
 =?utf-8?B?S3N4TlJldVVoaVN3Nm1vb21FaWtQSGhxUHVia0dwMWlDcUNOVFIxb3ZzckRT?=
 =?utf-8?B?MXY4MnFlRHVXVVpJYkw4S3duYnhaVHVaZ1psRXZhK2VkRXpHVjRPQlZLaWNp?=
 =?utf-8?B?VlFHdnhWRHNUQkZjRDlHYm5jYnREMlliU1UvM0p2R3NqR3NmQU9RaDVpZTFl?=
 =?utf-8?B?UG8vSkFEdXB4d0VFWnRaK3V4U0JQMVlpSG1JOUhkRkFydzNuNFRIWElPaGYz?=
 =?utf-8?B?YnljQ2tWVTdlTHE0eHpLem5JenpXM1hRYXdxRzlhWnJvc1ZsVWh4QWY1eTVa?=
 =?utf-8?B?WDBvQkJqVDJvdTFJaGdEUjBBdTg0M1ViNGNYczlqN3pjcEdkOGpBRkZ3UFlH?=
 =?utf-8?B?aVBtbE1xRlhhMjVEZVRjNUh2blJESmFNdkdlUmQ3cnE1TTJkTGVRMWtQVkdz?=
 =?utf-8?B?bWx0Y3NER213R21sdFlZMmxENDgvS2pMeUpQdGRwaTA1clZXTWR0bnRkRmJS?=
 =?utf-8?B?cTR1NGZ4TS9OaVcvd1ZBRkEzVUdCNVZReU5MNGRiYUhLRVFNOVppS1pEcFR0?=
 =?utf-8?Q?HJ28=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A676511E0E51514C86EF72007CB25E59@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e328700-24b9-41c3-3263-08dc15a9b3c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 09:09:38.8831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GAh84y42A/ZPbx3IHCcNryokN3uHfJcK4BKqhmtpD32wnC6kqXQd8v4mE6TVecLWmyRuuq3ntX0n3kG6jbuiBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5845
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES

T24gMjAyNC8xLzE1IDE2OjUyLCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+IA0KPj4gRnJvbTogQ2hl
biwgSmlxaWFuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KPj4gU2VudDogTW9uZGF5LCBKYW51YXJ5
IDE1LCAyMDI0IDE6NTEgUE0NCj4+DQo+PiBPbiAyMDI0LzEvMTUgMTU6NTUsIFBhcmF2IFBhbmRp
dCB3cm90ZToNCj4+Pg0KPj4+PiBGcm9tOiBDaGVuLCBKaXFpYW4gPEppcWlhbi5DaGVuQGFtZC5j
b20+DQo+Pj4+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAxNSwgMjAyNCAxOjE4IFBNDQo+Pj4+DQo+
Pj4+IE9uIDIwMjQvMS8xNSAxNTozNywgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPj4+Pj4NCj4+Pj4+
PiBGcm9tOiBDaGVuLCBKaXFpYW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+Pj4+Pj4gU2VudDog
TW9uZGF5LCBKYW51YXJ5IDE1LCAyMDI0IDE6MDMgUE0NCj4+Pj4+Pg0KPj4+Pj4+IE9uIDIwMjQv
MS8xMiAxNzo0NCwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPj4+Pj4+Pg0KPj4+Pj4+Pg0KPj4+Pj4+
Pj4gRnJvbTogQ2hlbiwgSmlxaWFuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KPj4+Pj4+Pj4gU2Vu
dDogRnJpZGF5LCBKYW51YXJ5IDEyLCAyMDI0IDI6NTUgUE0NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBP
biAyMDI0LzEvMTIgMTY6NDcsIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4+Pj4+Pj4+Pg0KPj4+Pj4+
Pj4+DQo+Pj4+Pj4+Pj4+IEZyb206IENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4N
Cj4+Pj4+Pj4+Pj4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDEyLCAyMDI0IDE6NTUgUE0NCj4+Pj4+
Pj4+Pj4NCj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4gT24gMjAyNC8xLzEyIDE2OjAyLCBQYXJhdiBQ
YW5kaXQgd3JvdGU6DQo+Pj4+Pj4+Pj4+PiBIaSBKaXFpYW4sDQo+Pj4+Pj4+Pj4+Pg0KPj4+Pj4+
Pj4+Pj4+IEZyb206IENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4+Pj4+Pj4+
Pj4+PiBTZW50OiBGcmlkYXksIEphbnVhcnkgMTIsIDIwMjQgMToxMSBQTQ0KPj4+Pj4+Pj4+Pj4N
Cj4+Pj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+Pj4+IEhpIGFsbCwNCj4+Pj4+Pj4+Pj4+PiBTb3JyeSB0
byByZXBseSBsYXRlLg0KPj4+Pj4+Pj4+Pj4+IEkgZG9uJ3Qga25vdyBpZiB5b3Ugc3RpbGwgcmVt
ZW1iZXIgdGhpcyBwcm9ibGVtLCBsZXQgbWUNCj4+Pj4+Pj4+Pj4+PiBicmllZmx5IGRlc2NyaXB0
DQo+Pj4+Pj4+PiBpdC4NCj4+Pj4+Pj4+Pj4+PiBJIGFtIHdvcmtpbmcgdG8gaW1wbGVtZW50IHZp
cnRncHUgUzMgZnVuY3Rpb24gb24gWGVuLg0KPj4+Pj4+Pj4+Pj4+IEN1cnJlbnRseSBvbiBYZW4s
IGlmIHdlIHN0YXJ0IGEgZ3Vlc3QgdGhyb3VnaCBxZW11IHdpdGgNCj4+Pj4+Pj4+Pj4+PiBlbmFi
bGluZyB2aXJ0Z3B1LCBhbmQgdGhlbiBzdXNwZW5kIGFuZCByZXN1bWUgZ3Vlc3QuIFdlIGNhbg0K
Pj4+Pj4+Pj4+Pj4+IGZpbmQgdGhhdCB0aGUgZ3Vlc3Qga2VybmVsIGNvbWVzIGJhY2ssIGJ1dCB0
aGUgZGlzcGxheSBkb2Vzbid0Lg0KPj4+Pj4+Pj4+Pj4+IEl0IGp1c3Qgc2hvd24gYSBibGFjaw0K
Pj4+Pj4+Pj4+PiBzY3JlZW4uDQo+Pj4+Pj4+Pj4+Pj4gVGhhdCBpcyBiZWNhdXNlIGR1cmluZyBz
dXNwZW5kaW5nLCBndWVzdCBjYWxsZWQgaW50byBxZW11IGFuZA0KPj4+Pj4+Pj4+Pj4+IHFlbXUg
ZGVzdHJveWVkIGFsbCBkaXNwbGF5IHJlc291cmNlcyBhbmQgcmVzZXQgcmVuZGVyZXIuIFRoaXMN
Cj4+Pj4+Pj4+Pj4+PiBtYWRlIHRoZSBkaXNwbGF5IGdvbmUgYWZ0ZXIgZ3Vlc3QgcmVzdW1lZC4N
Cj4+Pj4+Pj4+Pj4+PiBTbywgSSBhZGQgYSBuZXcgY29tbWFuZCBmb3IgdmlydGlvLWdwdSB0aGF0
IHdoZW4gZ3Vlc3QgaXMNCj4+Pj4+Pj4+Pj4+PiBzdXNwZW5kaW5nLCBpdCB3aWxsIG5vdGlmeSBx
ZW11IGFuZCBzZXQNCj4+Pj4+Pj4+Pj4+PiBwYXJhbWV0ZXIocHJlc2VydmVyX3Jlc291cmNlKSB0
byAxIGFuZCB0aGVuIHFlbXUgd2lsbA0KPj4+Pj4+Pj4+Pj4+IHByZXNlcnZlIHJlc291cmNlcywg
YW5kIHdoZW4gcmVzdW1pbmcsIGd1ZXN0IHdpbGwgbm90aWZ5IHFlbXUNCj4+Pj4+Pj4+Pj4+PiB0
byBzZXQgcGFyYW1ldGVyIHRvIDAsIGFuZCB0aGVuIHFlbXUgd2lsbCBrZWVwIHRoZSBub3JtYWwN
Cj4+IGFjdGlvbnMuDQo+Pj4+Pj4+Pj4+Pj4gVGhhdCBjYW4NCj4+Pj4+Pj4+IGhlbHAgZ3Vlc3Qn
cyBkaXNwbGF5IGNvbWUgYmFjay4NCj4+Pj4+Pj4+Pj4+PiBXaGVuIEkgdXBzdHJlYW0gYWJvdmUg
aW1wbGVtZW50YXRpb24sIFBhcmF2IGFuZCBNU1Qgc3VnZ2VzdA0KPj4+Pj4+Pj4+Pj4+IG1lDQo+
Pj4+Pj4gdG8NCj4+Pj4+Pj4+Pj4gdXNlDQo+Pj4+Pj4+Pj4+Pj4gdGhlIFBNIGNhcGFiaWxpdHkg
dG8gZml4IHRoaXMgcHJvYmxlbSBpbnN0ZWFkIG9mIGFkZGluZyBhIG5ldw0KPj4+Pj4+Pj4+Pj4+
IGNvbW1hbmQgb3Igc3RhdGUgYml0Lg0KPj4+Pj4+Pj4+Pj4+IE5vdywgSSBoYXZlIHRyaWVkIHRo
ZSBQTSBjYXBhYmlsaXR5IG9mIHZpcnRpby1ncHUsIGl0IGNhbid0DQo+Pj4+Pj4+Pj4+Pj4gYmUg
dXNlZCB0byBzb2x2ZSB0aGlzIHByb2JsZW0uDQo+Pj4+Pj4+Pj4+Pj4gVGhlIHJlYXNvbiBpczoN
Cj4+Pj4+Pj4+Pj4+PiBkdXJpbmcgZ3Vlc3Qgc3VzcGVuZGluZywgaXQgd2lsbCB3cml0ZSBEMyBz
dGF0ZSB0aHJvdWdoIFBNDQo+Pj4+Pj4+Pj4+Pj4gY2FwLCB0aGVuIEkgY2FuIHNhdmUgdGhlIHJl
c291cmNlcyBvZiB2aXJ0aW8tZ3B1IG9uIFFlbXUNCj4+Pj4+Pj4+Pj4+PiBzaWRlKHNldCBwcmVz
ZXJ2ZXJfcmVzb3VyY2UgdG8gMSksIGJ1dCBkdXJpbmcgdGhlIHByb2Nlc3Mgb2YNCj4+Pj4+Pj4+
Pj4+PiByZXN1bWluZywgdGhlIHN0YXRlIG9mIFBNIGNhcCB3aWxsIGJlIGNsZWFyZWQgYnkgcWVt
dQ0KPj4+Pj4+Pj4+Pj4+IHJlc2V0dGluZyhxZW11X3N5c3RlbV93YWtldXAtPiBxZW11X2Rldmlj
ZXNfcmVzZXQtPg0KPj4+Pj4+Pj4+Pj4+IHZpcnRpb192Z2FfYmFzZV9yZXNldC0+IHZpcnRpb19n
cHVfZ2xfcmVzZXQpLCBpdCBjYXVzZXMgdGhhdA0KPj4+Pj4+Pj4+Pj4+IHdoZW4gZ3Vlc3QgcmVh
ZHMgc3RhdGUgZnJvbSBQTSBjYXAsIGl0IHdpbGwgZmluZCB0aGUNCj4+Pj4+Pj4+Pj4+PiB2aXJ0
aW8tZ3B1IGhhcyBhbHJlYWR5IGJlZW4gRDAgc3RhdGUsDQo+Pj4+Pj4+Pj4+PiBUaGlzIGJlaGF2
aW9yIG5lZWRzIHRvIGJlIGZpeGVkLiBBcyB0aGUgc3BlYyBsaXN0ZWQgb3V0LCAiDQo+Pj4+Pj4+
Pj4+PiBUaGlzIDItYml0IGZpZWxkIGlzDQo+Pj4+Pj4+Pj4+IHVzZWQgYm90aCB0byBkZXRlcm1p
bmUgdGhlIGN1cnJlbnQgcG93ZXIgc3RhdGUgb2YgYSBGdW5jdGlvbiINCj4+Pj4+Pj4+Pj4gRG8g
eW91IG1lYW4gaXQgaXMgd3JvbmcgdG8gcmVzZXQgUE0gY2FwIHdoZW4gdnJpdGlvX2dwdSByZXNl
dA0KPj4+Pj4+Pj4+PiBpbiBjdXJyZW50IHFlbXUgY29kZT8gV2h5Pw0KPj4+Pj4+Pj4+IEJlY2F1
c2UgUE0gaXMgaW1wbGVtZW50aW5nIHRoZSBzdXBwb3J0IGZyb20gRDMtPmQwIHRyYW5zaXRpb24N
Cj4+Pj4+Pj4+PiBhbmQgaWYgaXQNCj4+Pj4+Pj4+IGRldmljZSBpbiBEMywgdGhlIGRldmljZSBu
ZWVkcyB0byByZXNwb25kIHRoYXQgaXQgaXMgaW4gRDMgdG8NCj4+Pj4+Pj4+IG1hdGNoIHRoZSBQ
Q0kgc3BlYy4NCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+PiBTaG91bGRuJ3QgYWxsIGRldmljZSBzdGF0
ZXMsIGluY2x1ZGluZyBQTSByZWdpc3RlcnMsIGJlIHJlc2V0DQo+Pj4+Pj4+Pj4+IGR1cmluZyB0
aGUgcHJvY2VzcyBvZiB2aXJ0aW8tZ3B1IHJlc2V0Pw0KPj4+Pj4+Pj4+IElmIE5vX1NvZnRfUmVz
ZXQ9PSAwLCBubyBkZXZpY2UgY29udGV4dCB0byBiZSBwcmVzZXJ2ZWQuDQo+Pj4+Pj4+Pj4gSWYg
Tm9fU29mdF9SZXNldCA9PSAxLCBkZXZpY2UgdG8gcHJlc2VydmUgbWluaW1hbCByZWdpc3RlcnMg
YW5kDQo+Pj4+Pj4+Pj4gb3RoZXINCj4+Pj4+Pj4+IHRoaW5ncyBsaXN0ZWQgaW4gcGNpIHNwZWMu
DQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+PiBTbyBkZXZp
Y2UgbmVlZHMgdG8gcmV0dXJuIEQzIGluIHRoZSBQb3dlclN0YXRlIGZpZWxkLiAgVGhpcyBpcyBt
dXN0Lg0KPj4+Pj4+Pj4+PiBCdXQgY3VycmVudCBiZWhhdmlvciBpcyBhIGtpbmQgb2Ygc29mdCBy
ZXNldCwgSQ0KPj4+Pj4+Pj4+PiB0aGluayghUENJX1BNX0NUUkxfTk9fU09GVF9SRVNFVCkuIFRo
ZSBwbSBjYXAgaXMgcmVzZXQgYnkNCj4+IHFlbXUNCj4+Pj4gaXMNCj4+Pj4+Pj4+Pj4gcmVhc29u
YWJsZS4NCj4+Pj4+Pj4+PiBXaGF0IHlvdSBkZXNjcmliZWQgaXMsIHlvdSBuZWVkIHRvIGRvIE5v
X1NvZnRfUmVzZXQ9MSwgc28gcGxlYXNlDQo+Pj4+Pj4+Pj4gc2V0IHRoZQ0KPj4+Pj4+Pj4gY2Fw
IGFjY29yZGluZ2x5IHRvIGFjaGlldmUgdGhlIHJlc3RvcmUuDQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+
PiBBbHNvIGluIHlvdXIgY2FzZSB0aGUgaWYgdGhlIFFFTVUga25vd3MgdGhhdCBpdCB3aWxsIGhh
dmUgdG8NCj4+Pj4+Pj4+PiByZXN1bWUgdGhlDQo+Pj4+Pj4+PiBkZXZpY2Ugc29vbi4NCj4+Pj4+
Pj4+PiBIZW5jZSwgaXQgY2FuIHdlbGwgcHJlcGFyZSB0aGUgZ3B1IGNvbnRleHQgYmVmb3JlIHJl
c3VtaW5nIHRoZSB2Y3B1cy4NCj4+Pj4+Pj4+PiBJbiBzdWNoIGNhc2UsIHRoZSBleHRyYSByZWdp
c3RlciB3b3VsZG7igJl0IGJlIG5lY2Vzc2FyeS4NCj4+Pj4+Pj4+PiBIYXZpbmcgUE0gY29udHJv
bCByZWdpc3RlciBpcyBhbnl3YXkgbmVlZGVkIHRvIGRyaXZlIHRoZSBkZXZpY2UNCj4+Pj4gcHJv
cGVybHkuDQo+Pj4+Pj4+PiBFdmVuIGFzIHlvdSBzYWlkLCB0aGUgcmVzZXQgYmVoYXZpb3Igb2Yg
UE0gaW4gdGhlIGN1cnJlbnQgUUVNVQ0KPj4+Pj4+Pj4gY29kZSBpcyBpbmNvcnJlY3QsIGFuZCBl
dmVuIGlmIGl0IGlzIG1vZGlmaWVkLCBpdCBhbHNvIGNhbm5vdCBmaXgNCj4+Pj4+Pj4+IHRoaXMg
cHJvYmxlbSB3aXRoDQo+Pj4+IFMzLg0KPj4+Pj4+PiBZb3UgbWVhbnQgRDM/DQo+Pj4+Pj4+DQo+
Pj4+Pj4+PiBCZWNhdXNlIHRoZXJlIGlzIHR3aWNlIGRldmljZSByZXNldCBkdXJpbmcgcmVzdW1p
bmcuDQo+Pj4+Pj4+PiBGaXJzdCBpcyB3aGVuIHdlIHRyaWdnZXIgYSByZXN1bWUgY29tbWFuZCB0
byBxZW11LCBxZW11IHdpbGwNCj4+Pj4+Pj4+IHJlc2V0IGRldmljZShxZW11X3N5c3RlbV93YWtl
dXAtPiBxZW11X2RldmljZXNfcmVzZXQtPg0KPj4+Pj4+Pj4gdmlydGlvX3ZnYV9iYXNlX3Jlc2V0
LT4gdmlydGlvX2dwdV9nbF9yZXNldCkuDQo+Pj4+Pj4+IEEgZGV2aWNlIGltcGxlbWVudGF0aW9u
IHRoYXQgc3VwcG9ydHMgUE0gc2hvdWxkIG5vdCByZXNldCB0aGUgZGV2aWNlLg0KPj4+Pj4+IFBs
ZWFzZSBmaXggaXQuDQo+Pj4+Pj4gRG8geW91IG1lYW4gdGhlIGRldmljZXNfcmVzZXQgYmVoYXZp
b3Igb2YgcWVtdSBzaG91bGRuJ3QgaGFwcGVuDQo+Pj4+Pj4gd2hlbiBhIGRldmljZSBoYXMgUE0g
Y2FwPw0KPj4+Pj4gUmlnaHQuIERldmljZSByZXNldCBzaG91bGQgbm90IGhhcHBlbiBvbiBQTSBj
YXBhYmxlIGRldmljZSB0aGF0DQo+Pj4+PiBvZmZlcnMNCj4+Pj4gbm9fc29mdF9yZXNldD09MS4N
Cj4+Pj4gQnV0IGN1cnJlbnQgcWVtdSBjb2RlLCBub19zb2Z0X3Jlc2V0PT0wLg0KPj4+Pg0KPj4+
IFNvIHBsZWFzZSBmaXggdGhlIHFlbXUgd2hlbiB5b3UgYXJlIGFkZGluZyB0aGUgZnVuY3Rpb25h
bGl0eSBvZiByZXN0b3JpbmcNCj4+IHRoZSBkZXZpY2UgY29udGV4dCBvbiBQTS4NCj4+IE15IHBh
dGNoIGRpZG4ndCBhZGQgdGhlIGZ1bmN0aW9uYWxpdHkgb2YgcmVzdG9yaW5nIHRoZSBkZXZpY2Ug
Y29udGV4dCBvbiBQTS4NCj4+IElzIG5vX3NvZnRfcmVzZXQgbXVzdCBzZXQgMSB3aGVuIGEgZGV2
aWNlIGhhcyBQTSBjYXA/IA0KPiANCj4gSXQgdGhlIGRldmljZSB3YW50cyB0byBleHBvc2UgdGhl
IGFiaWxpdHkgdG8gc2F2ZSBhbmQgcmVzdG9yZSBjb250ZXh0LCB0aGVuIHllcywgbm9fc29mdF9y
ZXNldCA9IDEsIGFzIGRlZmluZWQgYnkgdGhlIFBDSSBzcGVjLg0KPiANCj4+IEl0IHNob3VsZCBh
bHNvIGJlDQo+PiBhbGxvd2VkIGZvciBzaXR1YXRpb25zIHRoYXQgYXJlIG5vdCBlcXVhbCB0byAx
LCByaWdodD8NCj4gSSBkb27igJl0IHNlZSB0aGUgbmVlZCBvZiBpdC4gSXQgd291bGQgbm90IGJl
IGFsaWduZWQgdG8gbm9fc29mdF9yZXNldCBiaXQgYWxyZWFkeSBkZWZpbmVkIGJpdC4NCj4gDQo+
PiBUaGVyZSBzaG91bGQgYmUgZGV2aWNlcyB0aGF0IGhhcyBQTSBjYXAgYnV0IG5vX3NvZnRfcmVz
ZXQgaXMgMCBiZWNhdXNlIHRoYXQNCj4+IGRldmljZXMgY2FuJ3Qgc3RvcmUgYW5kIHJlc3RvcmUg
dGhlIGRldmljZSBjb250ZXh0IG9uIGQzLT5kMCB0cmFuc2l0aW9uLCBsaWtlDQo+PiBjdXJyZW50
IHFlbXUgY29kZS4NCj4gUmlnaHQsIFBNIGNhcCB3aXRoIG5vX3NvZnRfcmVzZXQ9MCwgd2lsbCBu
b3QgcmVzdG9yZSB0aGUgY29udGV4dCBvbiBkMy0+ZDAgYXMgdG9kYXkuDQo+IA0KPj4gU28gdGhl
IGZpeCBzaG91bGQgYmUgZmVhc2libGUgZm9yIGFsbCBzaXR1YXRpb25zIHRoYXQgd2hldGhlciB0
aGUgbm9fc29mdF9yZXNldCBpcw0KPj4gMSBvciBub3QuDQo+IEkgZG9u4oCZdCBmb2xsb3cgdGhl
ICJmaXggc2hvdWxkIGJlIGZlYXNpYmxlIi4NCkkgbWVhbiB0aGUgZml4IHRoYXQgdG8gc29sdmUg
dGhlIHByb2JsZW0odmlydGlvLWdwdSdzIGRpc3BsYXkgcmVzb3VyY2VzIGFyZSBkZXN0cm95ZWQg
ZHVyaW5nIFMzKSBzaG91bGQgYWxzbyBiZSBmZWFzaWJsZSB0byB0aGUgc2l0dWF0aW9uIHRoYXQg
bm9fc29mdF9yZXNldCA9PSAwLg0KDQo+IFFFTVUgcmVzZXQgdGhlIGRldmljZSBvbiBkMy0+ZDAg
dHJhbnNpdGlvbiB3aGVuIG5vX3NvZnRfcmVzZXQgPSAwIHNlZW1zIGZpbmUgYmVjYXVzZSBpdCBm
b2xsb3dzIHRoZSBkZWZpbmVkIHBjaSBzcGVjLg0KUmlnaHQuDQpOb3cgdGhhdCB5b3UgYWxzbyB0
aGluayB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBvZiBRRU1VIGlzIHJlYXNvbmFibGUsIHRo
ZSBmaXggdG8gdGhpcyBwcm9ibGVtKGRpc3BsYXkgcmVzb3VyY2VzIGFyZSBkZXN0cm95ZWQgZHVy
aW5nIFMzKSBzaG91bGQgYmUgYXBwbGljYWJsZSB0byB0aGUgY3VycmVudCBRRU1VIGNvZGUuDQpJ
ZiB1c2luZyBQTSBjYXAsIGl0IGNhbm5vdCBzb2x2ZSB0aGUgcHJvYmxlbSBlbmNvdW50ZXJlZCBp
biBjdXJyZW50IFFFTVUgY29kZS4NCkkgdGhpbmsgeW91IG1heSBub3QgaGF2ZSBoYWQgYSBkZXRh
aWxlZCB1bmRlcnN0YW5kaW5nIG9mIG15IG1vZGlmaWNhdGlvbnMuIEkgd2lsbCByZXNlbmQgdGhl
IGxhdGVzdCBtb2RpZmljYXRpb25zIG9uIHRoZSBMaW51eCBrZXJuZWwgYW5kIFFFTVUgdG8gdXBz
dHJlYW0uDQpXZWxjb21lIHRvIHJldmlldy4NCg0KPiANCj4+IElmIHVzZSBQTSBjYXAsIG5vdCBl
dmVyeSBzaXR1YXRpb24gY2FuIHNvbHZlIGN1cnJlbnQgcHJvYmxlbSAoZGlzcGxheQ0KPj4gcmVz
b3VyY2VzIG9mIEdQVSB3aWxsIGJlIGRlc3Ryb3llZCkuDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0K
SmlxaWFuIENoZW4uDQo=

