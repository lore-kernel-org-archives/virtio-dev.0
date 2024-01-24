Return-Path: <virtio-dev-return-14274-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F642C47DDF
	for <virtio-dev@archiver.kernel.org>; Wed, 24 Jan 2024 13:18:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DC9C62A8E4
	for <virtio-dev@archiver.kernel.org>; Wed, 24 Jan 2024 13:18:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D74389867ED
	for <virtio-dev@archiver.kernel.org>; Wed, 24 Jan 2024 13:18:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CB0309867D8; Wed, 24 Jan 2024 13:18:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B57609867D9;
	Wed, 24 Jan 2024 13:18:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMiKlv8BjUiB8OoxU+mfVGTuQvcPJjWBZYyHPn9gLvLAdxyrmLYhk3S+OaV1TgjIpbmBamLi3d6ToHshUPbQBAP3pyWfEOIlN5IF+nVzN/GUTQGSWX6rRfGjlL2zKpoh24uH5oa4iJYB53GdQKxzDY+BVNxHTmFkGUo5EYbr9h4bRyxr8d75yqS2OTJH1RZwJKKp6F83dzfCXy4zqDZfZr7haJ0uVz66rndTSZAkJ4F9SbinuC500Pzy1bMaY3PUS7sWja7HfvWpeePvjXFXj07nUTBtpKCtOrhyhHBz6lUukEYUQdDhnWlqg+9D0yNWR02Egd3Rw7miWMKTDddngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEgixX0Xg/TkzHy30pLS1z8+uvwviyZ039IY6CfwV10=;
 b=U8b3LIjFCKRVaUbTsFt9TpRCZalbl/FSx9YjzXF4JAyA0OoCJVZKf+XEEOSDXYkekYjr5PFTZpdaqjP18CT3ZEfBobHg/2rKV+NTv1VXFNtEwQictuH5QMUwDUYx7YqYM2GrWleu+qfW4LWI+0Nj8WzazkpH2aG+/DGtAyVMM1B5hZgbRcRLC5mmKHtqZb7Y/MkkUzI1Q50AxK/Vw2kEvqfGTnItgCzdTrWsrdxTw/hdhG5H5NTGF1hSxWI7e27LFkucYS3/oTmEZs7bYORZOXY1G9Vh5RMxEjdXoQ75LZHT5YkUb2peA5wHoq5fXqG6ClesPUNf9TgVfIC9bViZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
CC: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-dev] RE: [virtio-comment] RE: [virtio-dev] RE:
 [virtio-comment] [PATCH v2] virtio-net: support setting coalescing params for
 multiple vqs
Thread-Index:
 AQHaR7Oe9QgTrn5GM0iGz2gHNb3tkrDa2d1ggAKYiwCABQnskIACsaqAgAAdlFCAA6/pAIAAArBg
Date: Wed, 24 Jan 2024 13:18:04 +0000
Message-ID:
 <PH0PR12MB54819844499B9D43865EDC4CDC7B2@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <1705323962-96063-1-git-send-email-hengqi@linux.alibaba.com>
 <PH0PR12MB5481EA21646CEA571FF2D3F9DC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3977e2c2-f514-4b51-a646-6f729df7403d@linux.alibaba.com>
 <DM8PR12MB5480872B5E7A67D65325485BDC772@DM8PR12MB5480.namprd12.prod.outlook.com>
 <db56402e-2432-4902-b58d-6b43a4f1dd0e@linux.alibaba.com>
 <PH0PR12MB5481E1A236C868B671275DCBDC752@PH0PR12MB5481.namprd12.prod.outlook.com>
 <078d541e-fac7-47ef-a69c-139d1e9b04f0@linux.alibaba.com>
In-Reply-To: <078d541e-fac7-47ef-a69c-139d1e9b04f0@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CO6PR12MB5474:EE_
x-ms-office365-filtering-correlation-id: fbff69fd-a41b-497b-9960-08dc1cdee5b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 oaPGJZSrAID/74QpU2Lg3LzI1dDZcn0VWW8FO4bL72g9aHpl/DFlRLvsPEs74d85fl3UWhQPIu0vgTWjvl1hp8TIIul/WJIrwlHpJhO8cONbeYerHk/wPfImN7v1sdDyCivV7PLE0phwruVyayzmmgMC5q74YO8YHYc/vcHkAIzDapE2xdoUgXgaKgeClBKBjc/ub0F8Q2u3i/SusqzDAFQJjAoPY0T2gTOyFLTNuVE1JXRqPUQDOM5YN8oq9ehIANtIcnnMSBBOaDDb6Okbl7qZ145MbmWltEi9IuCQEvfG4kHk03eKN7S/71O4qRqFdTpq/mV2rbtuyuROyWwF6mGgDqPvxAzB2rOdQe1AnLwFNt2yWc1bGBFRf9v7jNNpeHA1ht6oRzXcpLfNIBUNrXXEHLCHOSZxxLOPazO4oxmIBo2s9LVBmOCkpLXunhQ0k0LUH/wZF3+Gz76EuR4WtbjpKRWGkVyD/8Zi8dTXuTm/3Gpao1jaXu8ZBr7vn3ixlWiYXYnuiL/nRrEKgTCc9b5NvCpNtw4VdmsRKV0K0jLfTb1WPVR5xVs7NWuvLnFovxxVRE1Wp41COf2iIUd8UxpEjZezz5/uHesPNbQ17qWcN65bnCgilkktjqLePvaW7bFVX9Zg7/GjvH0E9wxNcZEr+1u2o1sbOsrglKqMQeHy+WJim+YWc8u6u7t9SWXOvMnYQZTvQLVy9oyHLbMkfw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(55016003)(110136005)(5660300002)(2906002)(316002)(54906003)(64756008)(66476007)(66556008)(66446008)(52536014)(4326008)(8936002)(66946007)(41300700001)(76116006)(8676002)(38070700009)(478600001)(33656002)(38100700002)(86362001)(122000001)(71200400001)(26005)(83380400001)(966005)(6506007)(9686003)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0c2djdicG54MWMyMThjaTVpWkFBYUJHTnoxT0FZYVRTMC9paDdwM3k0U25N?=
 =?utf-8?B?THNaemhDMFBka1BIMUw5SkFxMGtmWnVLbDB3cGtjc09hZG9FWmprVnBBUTFi?=
 =?utf-8?B?VFl2K3N5dndOVkM5YnYyQktqNjlDZE1kYlMxUEVTZERGOHBnblZhOTAxU1F2?=
 =?utf-8?B?VER2MG9HNSt2OXRaeE9XZy9GR3BnRjFNeFJObks3aVd4aEdqNVdLSzZldXV3?=
 =?utf-8?B?bk1MbU9CQ1pmd1MwamdpMEY0MlpSd0pkYVJZUkdrSHF0NFdrdjhTRFdJUW45?=
 =?utf-8?B?bEtZY29PWVVWZHZFcndiSmlpRjF5YTFLUStheEo2WlIydlJqaWltK0dKcUpY?=
 =?utf-8?B?RXl3RjdyTkl5UFVHSVpYVytqemQrWmlKcHM3M25FRmRiTjNucVg2SGs3QVBk?=
 =?utf-8?B?aURjUWw1ZzYwTGUrWVlVUWRYU0t4QXNPbm56MUZMcVNJRWI0cG9CYWhtQUNm?=
 =?utf-8?B?Y09PN29GRW1Cc0ZzNEg1MzB0TnI0NnYrUDBWQk9FL05VTnk3czFkRjJQenpF?=
 =?utf-8?B?aUpoV0lpdzJFZnlOM3ljd3BGdC9DTFd1UUVLdzI0SXcxVU9ySGRKM3pMQ0tt?=
 =?utf-8?B?dEdTa3V5SU1VWkRHRmFWRG9VcldNeGdGZnM2RXVTZnV5NmZic1pPcUtMaXll?=
 =?utf-8?B?NlpQdG9iVzYyU3FyRjhxSFpIZ1RhWkxWRll2dktyeDI3a0xsejZTelliZU1E?=
 =?utf-8?B?d3p2U1AyOEQwQ1JNTVpOUWM3VE9vV2d6VFFaT3JRVnhFVFdMVUlFQllabCt5?=
 =?utf-8?B?WEQxdGw4V0grdVMwVzdWcU8zTWNONFdHWkFxWXdrNlVKYWtIdmMyRW1OUzdU?=
 =?utf-8?B?M3ZrUEZ4Sk0rbCtMR0RETGtnR21vL1QvY1NZTGY2UGFtblVqWkVTdUp6QWNr?=
 =?utf-8?B?d1k2Nis1Nks4bU9FUThzVXZ3TEowU05rc0I4Nk5NSXJLclBxSFU0UDJ1dzlT?=
 =?utf-8?B?NWV6VE5JS1YwMUovRll2bFd5d1RhVzlPaG1NaU44dkFOUjAyalErWTJkeUJT?=
 =?utf-8?B?WElPTjVpUDIxcS8rU1dUK1VPZXBSaUJPWnBRSDRteTRjWk1kdmtJQnJjUW9n?=
 =?utf-8?B?TW5HcGlZN3NveThoTXNZT3p1cDlDNmlVQ1NnV3lGKzd5NkdLZFZKZUdBNFc2?=
 =?utf-8?B?VU5lbWV1anl3YjlvUldiZTFiV0pJSGQvUncxZXlPMyszbXR2ZFlTUmM4TG9W?=
 =?utf-8?B?Z0pSaW14UUg3Y3dYaytFZ2poOHFlZ2dnYnk4NThUejNacHlPUUNSNlBmM2w3?=
 =?utf-8?B?a1Mrc2hMa1VxWFhZV3E1MU9hTVhVTzM5Vm4vazd5M0h1OUxLU3krUmhSeVFa?=
 =?utf-8?B?MnUvdWNzbktEaFoyc3p4WWRQRkx5Y1FPVk5jdW4vN3F2UmhsMGN3RENsTjJR?=
 =?utf-8?B?SXRXOENHMjVKcnA4T1JhcXFQYlpiUDBvcFA5Q0RCU3F4ekM0Mms3c1RIYVFN?=
 =?utf-8?B?cUkwdVRmbHZDdk1ULzN0QWFucDVxREJmUUNRb1FKd3ZOejNnenAzS2p3alU5?=
 =?utf-8?B?am56aHJXNzg0cERIS2pWbVNMRmtVdWhVNjV3SngrZVM2YjdjekM2U3dlMVlo?=
 =?utf-8?B?cDY4MkJNYnVVR1VDNWlxeDYraWN3bSsrMDBqSVBOVXdSSXJCWStMQmdVUHM4?=
 =?utf-8?B?NzY4cmxWd0FURGUxbmNFTDhzdUNPMm90aDg2MnVYSFdqVm1qMUhLY3hIdUJm?=
 =?utf-8?B?Y245OXhRUXZYNzFRSWsvaU05RXdSYVFMUFp2OExiSyt6SFZETEdlWGtFak9D?=
 =?utf-8?B?cFc2aVpJaVEyTTY3S2htTkNLK0xSRGpERFpnUU05dzIwaEVEckYrZG9ubnR4?=
 =?utf-8?B?OVdwc3BTNXRmN203SVFkZm8zSlU4Tk1LU3VxNGk2MTVDTmVJeUtxNTVLSW5x?=
 =?utf-8?B?SFBwSGEzQU5NQ2tXZTN6SmxtNUJ5SG5aY0l0dE5LTURXamdkVjlaNmZZWHZD?=
 =?utf-8?B?L1BxY0x2ZW1kRmZ0RU4rT29PTzFiWDljT2k0TmVrdEdrY2prY3RoQ0cwOEFX?=
 =?utf-8?B?WWYzWENwK1ppS0p3Sk9vSVZscUdQMGhISnpkUm10eUM5cVNmYW5MN0IzUWli?=
 =?utf-8?B?UXVIQVBxc1RDSEpJWXJoejJvaFNiY2pRNklwL1NucXdYamNwMFJXYmhJb240?=
 =?utf-8?Q?vuLY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbff69fd-a41b-497b-9960-08dc1cdee5b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 13:18:04.1861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5YTspvHgC+qr02JIi9biF5kcgxe9GoFxVao58oSHBvy8aoDGDSYpj3azLPVcZRE5bTcYoCWnyqv8uEE+153+Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5474
Subject: RE: [virtio-dev] RE: [virtio-comment] RE: [virtio-dev] RE:
 [virtio-comment] [PATCH v2] virtio-net: support setting coalescing params for
 multiple vqs

DQo+IEZyb206IEhlbmcgUWkgPGhlbmdxaUBsaW51eC5hbGliYWJhLmNvbT4NCj4gU2VudDogV2Vk
bmVzZGF5LCBKYW51YXJ5IDI0LCAyMDI0IDY6MzEgUE0NCj4gDQo+IA0KPiDlnKggMjAyNC8xLzIy
IOS4i+WNiDE6MDMsIFBhcmF2IFBhbmRpdCDlhpnpgZM6DQo+ID4NCj4gPj4gRnJvbTogSGVuZyBR
aSA8aGVuZ3FpQGxpbnV4LmFsaWJhYmEuY29tPg0KPiA+PiBTZW50OiBNb25kYXksIEphbnVhcnkg
MjIsIDIwMjQgODoyNyBBTQ0KPiA+Pg0KPiA+PiDlnKggMjAyNC8xLzIwIOS4i+WNiDU6NTksIFBh
cmF2IFBhbmRpdCDlhpnpgZM6DQo+ID4+Pj4gRnJvbTogSGVuZyBRaSA8aGVuZ3FpQGxpbnV4LmFs
aWJhYmEuY29tPg0KPiA+Pj4+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAxNywgMjAyNCAxMDoy
MiBBTQ0KPiA+Pj4+DQo+ID4+Pj4g5ZyoIDIwMjQvMS8xNSDkuIvljYg5OjIxLCBQYXJhdiBQYW5k
aXQg5YaZ6YGTOg0KPiA+Pj4+Pj4gRnJvbTogdmlydGlvLWNvbW1lbnRAbGlzdHMub2FzaXMtb3Bl
bi5vcmcNCj4gPj4+Pj4+IDx2aXJ0aW8tY29tbWVudEBsaXN0cy5vYXNpcy0gb3Blbi5vcmc+IE9u
IEJlaGFsZiBPZiBIZW5nIFFpDQo+ID4+Pj4+PiBTZW50OiBNb25kYXksIEphbnVhcnkgMTUsIDIw
MjQgNjozNiBQTQ0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IEN1cnJlbnRseSwgd2hlbiBlYWNoIHRpbWUg
dGhlIGRyaXZlciBhdHRlbXB0cyB0byB1cGRhdGUgdGhlDQo+ID4+Pj4+PiBjb2FsZXNjaW5nIHBh
cmFtZXRlcnMgZm9yIGEgdnEsIGl0IG5lZWRzIHRvIGtpY2sgdGhlIGRldmljZSBhbmQNCj4gPj4+
Pj4+IHdhaXQgZm9yIHRoZSBjdHJscSByZXNwb25zZSB0byByZXR1cm4uDQo+ID4+Pj4+IEl0IGRv
ZXMgbm90IG5lZWQgdG8gd2FpdC4gVGhpcyBpcyBzb21lIGRyaXZlciBsaW1pdGF0aW9uIHRoYXQg
ZG9lcw0KPiA+Pj4+PiBub3QgdXNlDQo+ID4+Pj4gdGhlIHF1ZXVlIGFzICJxdWV1ZSIuDQo+ID4+
Pj4+IFN1Y2ggZHJpdmVyIGxpbWl0YXRpb24gc2hvdWxkIGJlIHJlbW92ZWQgaW4gdGhlIGRyaXZl
ci4gSXQgZG9lcw0KPiA+Pj4+PiBub3QgcXVhbGlmeQ0KPiA+Pj4+IGFzIGxpbWl0YXRpb24uDQo+
ID4+Pj4NCj4gPj4+PiBZZXMsIHdlIGRvbid0IGhhdmUgdG8gd2FpdC4NCj4gPj4+Pg0KPiA+Pj4+
IEJ1dCBpbiBnZW5lcmFsLCBmb3IgdXNlciBjb21tYW5kcywgaXQgaXMgbmVjZXNzYXJ5IHRvIG9i
dGFpbiB0aGUNCj4gPj4+PiBmaW5hbCByZXN1bHRzIHN5bmNocm9ub3VzbHkuDQo+ID4+PiBZZXMu
IFVzZSBpbml0aWF0ZWQgY29tbWFuZCBjYW4gZW5xdWV1ZSB0aGUgcmVxdWVzdCB0byBjdnEuIEdv
IHRvDQo+ID4+PiBzbGVlcA0KPiA+PiBmb3Igc2V2ZXJhbCBtaWNybyB0byBtaWxsaXNlY29uZHMu
DQo+ID4+Pj4gVGhlIHVzZXIgY29tbWFuZCBjYW5ub3QgcmV0dXJuIGJlZm9yZSB0aGUgZmluYWwg
cmVzdWx0IGlzIG9idGFpbmVkLg0KPiA+Pj4+IEFuZCB3YWl0IGlzIG5vdCB0aGUgcHJvYmxlbSB0
aGlzIHBhdGNoIHNvbHZlcy4NCj4gPj4+Pg0KPiA+Pj4gQnkgbm90IGhvbGRpbmcgdGhlIHJ0bmwg
bG9jaywgcmVzdCBvZiB0aGUgY29udGV4dCB0aGF0IG5lZWRzIHRvDQo+ID4+PiBlbnF1ZXVlIHRo
ZQ0KPiA+PiByZXF1ZXN0IGNhbiBwcm9ncmVzcyBzdWNoIGFzIHRoYXQgb2YgbmV0ZGltLg0KPiA+
Pg0KPiA+PiBXb3VsZCBsaWtlIHRvIHNlZSB0aGUgdXNpbmcgb2YgcnRubCBsb2NrIGNoYW5nZWQu
DQo+ID4+DQo+ID4gSW5zaWRlIHRoZSB2aXJ0bmV0X3J4X2RpbV93b3JrKCkgdGhlcmUgc2hvdWxk
IGJlIHJ0bmwgbG9jayBjYWxsLg0KPiA+IEEgdmlydGlvX2RldmljZSBsZXZlbCBsb2NrIHRvIGJl
IHVzZWQgZm9yIGN2cS4gOikNCj4gPg0KPiA+PiBJbiBhZGRpdGlvbiwgSSBoYXZlIG1hZGUgYmF0
Y2hpbmcgYW5kIGFzeW5jaHJvbm91c2l6YXRpb24gb2YgdGhlDQo+ID4+IG5ldGRpbSBjb21tYW5k
LCB5b3UgY2FuIHJlZmVyIHRvIHRoaXMgcGF0Y2g6DQo+ID4+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC8xNzA1NDEwNjkzLTExODg5NS00LWdpdC1zZW5kLWVtYWlsLQ0KPiA+PiBoZW5ncWlA
bGludXguYWxpYmFiYS5jb20vDQo+ID4+DQo+ID4gSW4gdGhlIGxpc3RlZCBhYm92ZSBkcml2ZXIg
cGF0Y2ggdGhlIG1vdGl2YXRpb24gInRvIG9wdGltaXplIHRoZSBDUFUNCj4gPiBvdmVyaGVhZCBv
ZiB0aGUgRElNIHdvcmtlciBjYXVzZWQgYnkgdGhlIGd1ZXN0IGJlaW5nIGJ1c3kgd2FpdGluZyBm
b3INCj4gPiB0aGUgY29tbWFuZCByZXNwb25zZSByZXN1bHQuIg0KPiA+DQo+ID4gSXMgbm90IHJp
Z2h0Lg0KPiA+IEJlY2F1c2UgZ3Vlc3QgaXMgc3RpbGwgYnVzeSB3YWl0aW5nLg0KPiANCj4gVGhl
cmUgaXMgbm8gYnVzeSB3YWl0IGZvciBndWVzdHMsIHNlZSBnZXRfY3ZxX3dvcmsoKS4NCj4gDQpP
ay4gbm90IGFsd2F5cyBidXN5IHdhaXRpbmcsIHNvbWV0aW1lcyBpdCBkb2VzLiB2aXJ0bmV0X2N2
cV9yZXNwb25zZSgpIHNob3VsZCBub3QgaGF2ZSBmbGFnLi4NCg0KV2hvIGV2ZXIgZ2V0cyB0aGUg
T1MgZ2xvYmFsIHJ0bmwgbG9jayBpcyBjYWxsaW5nIHZpcnRuZXRfY3ZxX3Jlc3BvbnNlKCkgYW5k
IGNoZWNraW5nIGFuZCByZWxlYXNpbmcuDQpTaG91bGRu4oCZdCBiZSBkb25lIHRoaXMgd2F5IHdp
dGggdHJ5IGxvY2sgZXRjLg0KUnRubCBsb2NrIGlzIG5vdCBzdXBwb3NlZCB0byBwcm90ZWN0IGxv
dyBsZXZlbCBkcml2ZXIgc29tZSBjdHJsdnEgcmVzcG9uc2UgZmxhZy4NCg0KDQo+ID4gV2l0aG91
dCBiYXRjaGluZywgZHVlIHRvIHJ0bmwgbG9jayBldmVyeSBWUSBjb21tYW5kIGlzIHNlcmlhbGl6
ZWQgYXMgb25lDQo+IG91dHN0YW5kaW5nIGNvbW1hbmQgYXQgYSB0aW1lIGluIHZpcnRuZXRfcnhf
ZGltX3dvcmsoKS4NCj4gPiBEdWUgdG8gdGhpcyBkZXZpY2UgaXMgdW5hYmxlIHRvIHRha2UgYmVu
ZWZpdCBvZiBETUEgYmF0Y2hpbmcgYXQgbGFyZ2Ugc2NhbGUuDQo+IA0KPiBBZGRpbmcgZGltIGNv
bW1hbmRzIGlzIG5vdyBhc3luY2hyb25vdXMsIGFuZCB0aGUgZGV2aWNlIHdpbGwgcmVjZWl2ZQ0K
PiBiYXRjaGVzIG9mIGNvbW1hbmRzLg0KPiANCkkgYW0gY29tcGFyaW5nIHRoZSBjb2RlIHdoZXJl
IHRoZXJlIGlzIG5vIHJ0bmwgbG9jayB3aXRoIHRoZSBjb2RlIHlvdSBwb3N0ZWQuDQpUaGUgcmVm
ZXJlbmNlIGNvZGUgb2YgcGF0Y2ggWzFdIG5lZWRzIHRvIGJlZ2luIHdpdGhvdXQgT1MgZ2xvYmFs
IHJ0bmwgbG9jayBhcyBiYXNlIGxpbmUuDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvMTcwNTQxMDY5My0xMTg4OTUtNC1naXQtc2VuZC1lbWFpbC1oZW5ncWlAbGludXguYWxpYmFi
YS5jb20vDQoNCj4gPg0KPiA+Pj4+PiBUaGlzIHdpbGwgZW5hYmxlIGRyaXZlciB0byBlbnF1ZXVl
IG11bHRpcGxlIGN2cSBjb21tYW5kcyB3aXRob3V0DQo+ID4+Pj4+IHdhaXRpbmcNCj4gPj4+PiBm
b3IgcHJldmlvdXMgb25lLg0KPiA+Pj4+PiBUaGlzIHdpbGwgYWxzbyBlbmFibGUgZGV2aWNlIHRv
IGZpbmQgbmF0dXJhbCBjb2FsZXNjaW5nIGRvbmUgb24NCj4gPj4+Pj4gbXVsdGlwbGUNCj4gPj4+
PiBjb21tYW5kcy4NCj4gPj4+Pg0KPiA+Pj4+IFdoZW4gYmF0Y2ggdXNlciBjb21tYW5kcyBvY2N1
ciwgZW5zdXJpbmcgc3luY2hyb25pemF0aW9uIGlzIGENCj4gY29uY2Vybi4NCj4gPj4+Pg0KPiA+
Pj4+Pj4gVGhlIGZvbGxvd2luZyBwYXRoIGlzIG9ic2VydmVkOiAxLiBEcml2ZXIga2lja3MgdGhl
IGRldmljZTsgMi4NCj4gPj4+Pj4+IEFmdGVyIHRoZSBkZXZpY2UgcmVjZWl2ZXMgdGhlIGtpY2ss
IENQVSBzY2hlZHVsaW5nIG9jY3VycyBhbmQgRE1BDQo+ID4+Pj4+PiBtdWx0aXBsZSBidWZmZXJz
IG11bHRpcGxlIHRpbWVzOyAzLiBUaGUgZGV2aWNlIGNvbXBsZXRlcw0KPiA+Pj4+Pj4gcHJvY2Vz
c2luZyBhbmQgcmVwbGllcw0KPiA+Pj4+IHdpdGggYSByZXNwb25zZS4NCj4gPj4+Pj4+IFdoZW4g
bGFyZ2UtcXVldWUgZGV2aWNlcyBpc3N1ZSBtdWx0aXBsZSByZXF1ZXN0cyBhbmQga2ljayB0aGUN
Cj4gPj4+Pj4+IGRldmljZSBmcmVxdWVudGx5LCB0aGlzIG9mdGVuIGludGVycnVwdCB0aGUgd29y
ayBvZiB0aGUgZGV2aWNlLXNpZGUgQ1BVLg0KPiA+Pj4+PiBXaGVuIHRoZXJlIGlzIGxhcmdlIGRl
dmljZXMgYW5kIG11bHRpcGxlIGRyaXZlciBub3RpZmljYXRpb25zIGJ5IGENCj4gPj4+Pj4gY3B1
IHRoYXQgaXMgTiB0aW1lcyBmYXN0ZXIgdGhhbiB0aGUgZGV2aWNlIHNpZGUgY3B1LCB0aGUgZGV2
aWNlDQo+ID4+Pj4+IG1heSBmaW5kIG5hdHVyYWwNCj4gPj4+PiBjb2FsZXNjaW5nIG9uIHRoZSBj
b21tYW5kcyBvZiBhIGdpdmVuIGN2cS4NCj4gPj4+Pg0KPiA+Pj4+IEZpcnN0IHdlIGhhdmUgdG8g
c29sdmUgdGhlIGN0cmxxIGJhdGNoIGFkZGluZyB1c2VyIChldGh0b29sKSBjb21tYW5kLg0KPiA+
Pj4+IEV2ZW4gaWYgcHJvY2Vzc2VkIGluIGEgYmF0Y2ggd2F5IG9uIGRldmljZSBzaWRlLCB0aGUg
bnVtYmVyIG9mDQo+ID4+Pj4ga2lja3MgYW5kIHRoZSBudW1iZXIgb2YgYmFja2VuZCBETUFzIGhh
cyBub3QgYmVlbiByZWR1Y2VkLg0KPiA+Pj4gRHJpdmVyIG5vdGlmaWNhdGlvbnMgYXJlIFBDSSB3
cml0ZXMgc28gaXQgc2hvdWxkIG5vdCBoYW1wZXIgZGV2aWNlDQo+ID4+PiBzaWRlLA0KPiA+PiB3
aGljaCBjYW4gaWdub3JlIHRoZW0gd2hlbiB0aGV5IGRvIG5vdCBib3RoZXIgYWJvdXQgaXQuDQo+
ID4+DQo+ID4+IERyaXZlciBub3RpZmljYXRpb25zIG5lZWQgdG8gYmUgcHJvY2Vzc2VkIGJ5IHRo
ZSBEUFUsIHdoaWNoDQo+ID4+IGludGVyZmVyZXMgd2l0aCB0aGUgQ1BVIG9uIHRoZSBEUFUuDQo+
ID4+DQo+ID4gSSB3YXMgYXNraW5nLCBpZiB0aGVyZSBpcyBhbnl3YXkgdG8gZGlzYWJsZSBmb3Ig
eW91ciBEUFUgdG8gaWdub3JlIHRoZXNlDQo+IG5vdGlmaWNhdGlvbnMgd2hpbGUgcHJldmlvdXMg
b25lIGlzIHBlbmRpbmc/DQo+ID4gIEZyb20geW91ciBhYm92ZSBkZXNjcmlwdGlvbiwgaXQgc2Vl
bXMgdGhlcmUgaXNu4oCZdC4NCj4gDQo+IFdoaWxlIHRoZSBkZXZpY2UgaXMgcHJvY2Vzc2luZyB0
aGUgcmVxdWVzdCwgYWRkaXRpb25hbCBraWNrcyBhcmUgaWdub3JlZC4NCj4gDQpPay4gdGhhdCBp
cyBnb29kLiBJbiB0aGF0IGNhc2UgdGhlIGtpY2tzIGFyZSBub3QgaW50ZXJmZXJpbmcsIHJpZ2h0
Pw0K

