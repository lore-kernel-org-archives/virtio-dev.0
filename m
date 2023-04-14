Return-Path: <virtio-dev-return-12229-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89080C77B70
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 03:51:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E291D2CAEA
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 03:51:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D4A1B986623
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 03:51:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C8919986601; Fri, 14 Apr 2023 03:51:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B50C1986600;
	Fri, 14 Apr 2023 03:51:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYVli5+w+fqjacAdYr5Ncs16WBQOZnwcSQLBDC6GDT0eDqig8+sDUTxgGoMNw/Kc4+TUMAn6L7+n09DdXMr6rhxDyAqjxZXDYdvC3YzAwKSyPDoDOP3CQgOBBqSUharhC17IDpf3RcAixQR1llm5tMMJBrKs3jXh88ea4Bx55GjaielAXUHBAAcHfyJqZl4iYwY7+rX/j8U13n1CHdbeux5B1GorqzPYuZyZ81eg9sd2iaAt3b0vET8pxBFtIi//jEj/ouvpTheSTgsBOSDP5zhu9ql78VU4/ajQw8bBtacLNw1h95cT5Q2FBJrduaU2rPaBbBddcblVLurR/1KIQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhV/tNcov0RzoMpBCssj1vQpsPiyFQdphgzP/363Vr4=;
 b=c4m7Wxao6LVxFpaK9WlFjmaYfnntUvyN3PciKF5Mx84H1aUrTl/9/a93fLrTNRMLjKCNdVLkEEXoqnGFSx+1sdAoYMVV79QFis4Q9bs/Z/DLPAq/YBoIklt+1UMdRn6JPWd4HU2Oc8VvXq+KDyD7SNTNgOe8ATfV/TgA1wxAvtVkQ2P+ELtBzFc6s1ZLS2OqwE36/DNWhH7p/R7FHRYamZQR07YbekRLi585DaJKJheH2JEOY3wHceLlvkIuUjtsoBtHmibLXN+8NpoQ0188PKQF2KruDlpxXNlabnzrqBdxDSMlZ0rO3BtgKrEFPdFLTMwfhJ2mVB++X+LnfXOmsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>, Yan Vugenfirer <yan@daynix.com>
Thread-Topic: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers
Thread-Index:
 AQHZY1tLAUtRpuZtUUOucQPGJlFfkK8flpUAgAQ7nwCAAE6hgIAAAXwAgAAFegCAAAt0AIAALl6AgAEOIwCAAFEgAIAAIPWAgAAcJ4CAASFtgIAABJ4AgAAKJYCAAACFsIAABgyAgAAAT3CAAAYpAIAAAJIAgAAJz4CAAILBcIAAxPiAgAAc1wCAABy4gIAAyrIAgAAhEfCAAIO9gIAAAWdQgAAGhACAAACJcA==
Date: Fri, 14 Apr 2023 03:51:01 +0000
Message-ID:
 <PH0PR12MB5481C29561D5E48BA5D8AEEEDC999@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB548118F57BB4B4A4F8DC9D7ADC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvYsz1fSPG+fKpRaZ05Ut7ffKwvMPvR8xbRBsXA_6vGQw@mail.gmail.com>
 <PH0PR12MB548137D7A25C99EAA42B4D12DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshW82qztmGw8YJWJ8=QCoRd6cPxQ+ySazxsO_o+U6c4Q@mail.gmail.com>
 <PH0PR12MB548147CF939CB9C2A0586310DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu2B_GogDR9HUwB7mT8fkGh+Q_buPLz4nhwhK7h9k6BQQ@mail.gmail.com>
 <PH0PR12MB5481F0CF5A555A6BB2CE856CDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuNOYOxvcSzrs0UFEyk+xOkGUpOfhK8rOy_Mebz5b5wdg@mail.gmail.com>
 <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com>
 <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
 <20230413130326-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819A5D8FCEC6375D80897DDC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvSSXyXQnRs=OiaSJnSEYHP83chL6-B5ZPCGx6TeW9W5Q@mail.gmail.com>
 <PH0PR12MB548135CF5268D979A6D8EDE8DC999@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsHtC99kTTa0TrfeJuhV+F7e-WF7XRgbLJkCBQeAxW8pA@mail.gmail.com>
In-Reply-To:
 <CACGkMEsHtC99kTTa0TrfeJuhV+F7e-WF7XRgbLJkCBQeAxW8pA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY5PR12MB6107:EE_
x-ms-office365-filtering-correlation-id: a7b11bdb-f5e7-4312-849a-08db3c9b7701
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iDk0WAGC459/uqr4aeF4NkxrK+G+unuKOXGIjFMwZF2qYyjNDLjWwwu2MJNFRxtJ5b4QTkZatN5hyOwmj9/+3eu+lZRRizNxUyO8LgzmMZF5iaQlGKB3JPb+8UoQ07nKDS7NyuXzsI2z+qULHRCa/BZZLMFPvCFHAmH/J/UbskgXVSmCGzAo9FBkuFv+4dWZw82S417Q/VScfxjKKenqauPe32xn28x47Y6WjBvNnnpUy0WqlDRAcLPE5W84DSNiNDfJAnAlHVLzd7EkYxRCEX+uJmiVHyKkBd761rDICBWu+bm5PIylzwK5nPWC4ekAOoP33TREk1L/WhTSDYu+8SNOAB/BLnSehnTQw27Kw3G0h28cuPVB8lfD2ihb4GeQxXdcwRNff+7cWzt6Vid6lPcVpLelOK/Rs9XZARYEgdljp+Y15QUqwwXmRTElMCpe2VFASi+NFvWdwAVmPDD49SrXU3Pu3ZXN8gioul5gOyepEIJYXZ2mza3yRPuf1IPDD3c/RXTxFyYM6f8sXajoT/gkWqpP29jj4R2i8iQtaWwhvIBEg9p0e/6ww2jVynQDQU3T3n3Zu9WxY6A8DHwTNJchpYLsDYFDjN4fK3P3V+9J0l5bme1Hl6xfdL8yBnRP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(9686003)(26005)(6506007)(54906003)(55016003)(186003)(83380400001)(71200400001)(7696005)(5660300002)(33656002)(52536014)(41300700001)(316002)(8676002)(8936002)(86362001)(38100700002)(38070700005)(122000001)(478600001)(66446008)(64756008)(4326008)(66946007)(76116006)(66476007)(66556008)(6916009)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T2NFNXo5dFJHVkZmVUZNbXZhNWYyVG1mU0pldkNyYXpoWG9VNW9yWjVwckdR?=
 =?utf-8?B?S0kyZVF5enNMRXRxQTFYWVFIZXl5YTA0UG1GUklLa1hSZTFNL1FmZy9rQ0c0?=
 =?utf-8?B?YU9YZ0FlYWh5SFpzTmNmODMvaWRXL1VybU94VHQyRXlGMXhEV0J3c0d2MHlt?=
 =?utf-8?B?anIyU1U1RUhXOHA1NnRzU3Yxa3BGWS9KMGZCY3VlMzFibHNFbjZPN2dJQm1v?=
 =?utf-8?B?QUh3bWJEbUEwTXdWRWlNZHN4YWQzY1lZWXAvWGdlNWFOeEIxYVpjanhrN0lV?=
 =?utf-8?B?TGtqbW90SVJSRHRnVThURFB0N08ycXEwdWxUMTJ6S3p6dVlDRDFicUZiWGt4?=
 =?utf-8?B?WHVpMURUZVZjZERNS0x4MzIzWXgxcFk1ekRIa2s2M2dnQ0N0d2xOdlU1MEpj?=
 =?utf-8?B?MjNWTmdhbm1SOGl6WDN4bWdLOWMrdHVGVXZtMmpuSkpIR1N1MzFNbllHVlc2?=
 =?utf-8?B?VkZNSi9OTzVVTUszNGcvR3JFVjhicGlDUmFBNlNCTkdweWc0SVlJZ0M2Y3NH?=
 =?utf-8?B?UGtQWGQ1UzJxNVg2T05oTmRHODF3MmRnTlBIaU9OVGZKbG1MY2YxalpPRytQ?=
 =?utf-8?B?NHd3U3c4SzRlMkNCRmpJeHpGQU1WYmFJSW4yVEFJcWgvRG1ob1I2SjhJUkpB?=
 =?utf-8?B?Z1dkV3BkUDJYcVNOSk9TT216R1haWU95NFpjRElGbndGaHpCSGRJNHl6TVBT?=
 =?utf-8?B?eXVuTUxadUdnM3RRc2VpdHVxQ3RJWlpUYzhaQXpUU1RUdE5DUjcyNXE4N1lD?=
 =?utf-8?B?QjRnamhPUmtkQVQ0NGtEU0FsQ2VsVFN6NkxGSHFTR1EvblNwUytPdERxL1gr?=
 =?utf-8?B?bWgzTTY3WUtGbWJFeS9YTzEyMFJneVEzck5DL1hSMElIVVp3UmM0dHkrNHNw?=
 =?utf-8?B?QnJRUkhOSDA3dlJic1VQV0MrZG5vZEpJT0R4VHFCR3dEMGJYeTE4K3RkY2dQ?=
 =?utf-8?B?dno3U3ZaNWhRZGFZd09IM05aN3BDaXNBNDQ2Vk9NcUswN1JMZGZHZWErMHZt?=
 =?utf-8?B?bGVqVU53ZldOeUYzWERwSkVVS3Z5dEQ3czg2WExlZHkrSlk3SDBZdHVXZjg2?=
 =?utf-8?B?RE5nYmgyeGVDVnN3RW8wNVVwQURQejdaZXhMV2tiUnlsbnFZUS81c2d2QUhS?=
 =?utf-8?B?blpLWWlFUER1K1pHUWY5Nmp2OVpHSnh0ZlVrWHFCSi9UcGJkLzluNkJOK1VO?=
 =?utf-8?B?eXY3L0ZaTmZjSmtoZi84NDVjVE9uTmF3UFlsVDltakp3THBwbTcwM0cweVNM?=
 =?utf-8?B?VEN6ZWR2Qi9JVHVXNDFNU2dqU2liVm9aM2Vrc0dFVDNHRXpFN2pJMGtZWXJh?=
 =?utf-8?B?VTNoa05CcFhGRGhYWUFlcXBZYmdvMDUyd2d5bDc1WHIyVUtvRzl4bGZENTVr?=
 =?utf-8?B?ajNsUS9tNGluUWFvWWlYejUrNlFjTUZZZGFTOUUrYWFkWFUyM01oRmFsSjJY?=
 =?utf-8?B?cDVrWndyNCs3dng4RE5rMjl1U2RNOEt2MFNiUlI5ZHJESk14Qlp1WDg2VEhX?=
 =?utf-8?B?T2J0YzRsS0lQT2dlMTdZTU5zTjZMS2tiVTZnWE9lK0hnQjlmWTlQOVZPbVZm?=
 =?utf-8?B?TEhpbzdXSVdVb0lwc1p1WmM5T0FEd05Ubld4MEx1ZE1nU0JXcDlxdGk4VW5I?=
 =?utf-8?B?SDAyY2NDc0x3bk01Vmh5N0VnL2x5bkF6dXQwMmdLQXEwK1dEUHdQZ1RnMS9i?=
 =?utf-8?B?NG5za0s2UVFNTG9remtNOXRGQnE2Q1JHQnFFMTVCQk11Y1NmTmZhZFlxWXA0?=
 =?utf-8?B?UmlaaFMwQzNVU3NIQzVySWJFWENoVmpWMmpiOTZBbzRQSm4xUzFwNXNZL3pj?=
 =?utf-8?B?dWVDb3RtWVI5bzh0dy9lMVp5Qk1ldUtWN3ZJazVITnBYek45bDV3L3djdVR1?=
 =?utf-8?B?djdiUFE4WkdUMlNocW9TYmVWN2R5eUlYamtJWG90LzlXcURVeDdGaWV6L2xw?=
 =?utf-8?B?NlhYUDZFaENmbXZUUDZCSXJOTGNud2JUVjFYTm9uTCtESnpJWklORGhQNnZq?=
 =?utf-8?B?WnRWTVdPUE05NXJMRythUWtjTnhvbEEzYkE1a2pqemRRRWZ6SUxxeVNkZjNH?=
 =?utf-8?B?N2hxbi93dHI2ZGV1NVJmS0lVZnc0UUZiYjBYbkRhaFdSaW9jbDVrckJoQ1Va?=
 =?utf-8?Q?tAKE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b11bdb-f5e7-4312-849a-08db3c9b7701
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 03:51:01.6642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AO6krOQEmxAua17wfsHp/3ZT/4Zd0rhiuS6adHBY5euJI+5axj9UiBMGlVf/Tedb7IqZA101WXk8fo8LSUGJjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6107
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIEFwcmlsIDEzLCAyMDIzIDExOjM4IFBNDQoNCj4gPiA+IDEpIHNwZWMgZG9lc24ndCBl
bmZvcmNlIHRoZSBzaXplIG9mIGEgc3BlY2lmaWMgc3RydWN0dXJlDQo+ID4gU3BlYyB3aWxsIGJl
IGV4dGVuZGVkIGluIGNvbWluZyB0aW1lLg0KPiANCj4gSXQncyB0b28gbGF0ZSB0byBkbyBhbnkg
bmV3IHJlc3RyaWN0aW9uIHdpdGhvdXQgaW50cm9kdWNpbmcgYSBmbGFnLg0KV2UgYXJlIHJlYWxs
eSBkaXZlcmdpbmcgZnJvbSB0aGUgdG9waWMuDQpJIGRvbuKAmXQgdGhpbmsgaXQgaXMgbGF0ZS4g
VGhlIHdvcmsgaW4gdGhpcyBhcmVhIG9mIFBDSSBWRiBoYXMgbm90IGV2ZW4gYmVndW4gZnVsbHku
DQoNCj4gTWFuZGF0aW5nIHNpemUgbWF5IGVhc2lseSBlbmQgdXAgd2l0aCBhIGFyY2hpdGVjdGUg
c3BlY2lmaWMgc29sdXRpb24uDQo+IA0KVW5saWtlbHkuIE90aGVyIHN0YW5kYXJkIGRldmljZSB0
eXBlcyBhcmUgYWxzbyBleHBhbmRpbmcgdGhpcyB3YXkuDQoNCj4gPg0KPiA+ID4gMikgYmluZyB2
ZW5kb3IgbG9ja2VkIHRodXMgYSBibG9ja2VyIGZvciBsaXZlIG1pZ3JhdGlvbiBhcyBpdA0KPiA+
ID4gbWFuZGF0ZSB0aGUgbGF5b3V0IGZvciB0aGUgZ3Vlc3QsIG1lZGlhdGlvbiBsYXllciBpcyBh
IG11c3QgaW4gdGhpcw0KPiA+ID4gY2FzZSB0byBtYWludGFpbiBjcm9zcyB2ZW5kb3IgY29tcGF0
aWJpbGl0eQ0KPiA+ID4NCj4gPiBXaXRoIFBDSSBWRiB3aWxsIGhhdmUgY29tcGF0aWJpbGl0eSBj
aGVjayBhbmQgYWxzbyB2ZW5kb3IgcmVjb21tZW5kYXRpb25zLg0KPiANCj4gSSdtIG5vdCBzdXJl
IHdoYXQgdHlwZSBvZiByZWNvbW1lbmRhdGlvbnMgeW91IHdhbnQuDQo+IA0KPiBXZSd2ZSBhbHJl
YWR5IGhhZDoNCj4gDQo+IDEpIGZlYXR1cmVzDQo+IDIpIGNvbmZpZw0KPg0KVGhvc2UgY292ZXIg
dGhlIGxhcmdlIHBhcnQuDQpBcGFydCBmcm9tIGl0IHNvbWUgb2YgdGhlIFBDSSBkZXZpY2UgbGF5
b3V0IGNvbXBhdCBjaGVja3Mgd2lsbCBiZSBjb3ZlcmVkIHRvby4NCiANCj4gQW5kIHdoYXQgeW91
IHByb3Bvc2VkIGlzIHRvIGFsbG93IHRoZSBtYW5hZ2VtZW50IHRvIGtub3cgdGhlIGV4YWN0DQo+
IGhhcmR3YXJlIGxheW91dCBpbiBvcmRlciB0byBjaGVjayB0aGUgY29tcGF0aWJpbGl0eT8gQW5k
IHRoZSBtYW5hZ2VtZW50DQo+IG5lZWRzIHRvIGV2b2x2ZSBhcyBuZXcgc3RydWN0dXJlcyBhcmUg
YWRkZWQuIA0KTW9zdGx5IG5vdCBtZ210IHN0YWNrIG1heSBub3QgbmVlZCB0byBldm9sdmUgYSBs
b3QuDQpCZWNhdXNlIG1vc3QgbGF5b3V0cyBzaG91bGQgYmUgZ3Jvd2luZyB3aXRoaW4gdGhlIGRl
dmljZSBjb250ZXh0IGFuZCBub3QgYXQgdGhlIFBDSSBjYXBhYmlsaXRpZXMgZXRjIGFyZWEuDQoN
CkFuZCBldmVuIGlmIGl0IGRvZXMsIGl0cyBmaW5lIGFzIGxhcmdlIHBhcnQgb2YgaXQgc3RhbmRh
cmQgUENJIHNwZWMgZGVmaW5pdGlvbnMuDQoNCj4gVGhpcyBjb21wbGljYXRlcyB0aGUgd29yayBv
Zg0KPiBtYW5hZ2VtZW50J3MgZnVydGhlcmx5IHdoaWNoIEknbSBub3Qgc3VyZSBpdCBjYW4gd29y
ay4NCj4NCldlbGwsIG9uY2Ugd2Ugd29yayB0b3dhcmRzIGl0LCBpdCBjYW4gd29yay4gOikNCg0K
PiA+DQo+ID4gPiBIeXBlcnZpc29yIG5lZWRzIHRvIHN0YXJ0IGZyb20gYSBtZWRpYXRpb24gbWV0
aG9kIGFuZCBkbyBCQVINCj4gPiA+IGFzc2lnbm1lbnQgb25seSB3aGVuIHBvc3NpYmxlLg0KPiA+
ID4NCj4gPiBOb3QgbmVjZXNzYXJpbHkuDQo+ID4NCj4gPiA+ID4gQ29uczoNCj4gPiA+ID4gYS4g
TW9yZSBBUSBjb21tYW5kcyB3b3JrIGluIHN3DQo+ID4gPg0KPiA+ID4gTm90ZSB0aGF0IHRoaXMg
bmVlZHMgdG8gYmUgZG9uZSBvbiB0b3Agb2YgdGhlIHRyYW5zcG9ydCB2aXJ0cXVldWUuDQo+ID4g
PiBBbmQgd2UgbmVlZCB0byBjYXJlZnVsbHkgZGVzaWduIHRoZSBjb21tYW5kIHNldHMgc2luY2Ug
dGhleSBjb3VsZCBiZQ0KPiA+ID4gbXV0dWFsbHkgZXhjbHVzaXZlLg0KPiA+ID4NCj4gPiBOb3Qg
c3VyZSB3aGF0IG1vcmUgdG8gZXhwZWN0IG91dCBvZiB0cmFuc3BvcnQgdmlydHF1ZXVlIGNvbXBh
cmVkIHRvIEFRLg0KPiA+IEkgZGlkbuKAmXQgZm9sbG93LCB3aGljaCBwYXJ0IGNvdWxkIGJlIG11
dHVhbGx5IGV4Y2x1c2l2ZT8NCj4gDQo+IFRyYW5zcG9ydCBWUSBhbGxvd3MgYSBtb2Rlcm4gZGV2
aWNlIHRvIGJlIHRyYW5zcG9ydGVkIHZpYSBhZG1pbnEuDQo+IA0KTWF5IGJlIGZvciBkZXZpY2Vz
IGl0IGNhbiB3b3JrLiBIeXBlcnZpc29yIG1lZGlhdGlvbiB3aXRoIENDIG9uIGhvcml6b24gZm9y
IG5ldyBjYXBhYmlsaXRpZXMgaXMgYmVpbmcgcmVkdWNlZC4NClNvIHdlIGRvbuKAmXQgc2VlIHRy
YW5zcG9ydCB2cSBtYXkgbm90IGJlIHBhdGggZm9yd2FyZC4NCg0KPiBBbmQgeW91IHdhbnQgdG8g
YWRkIGNvbW1hbmRzIHRvIHRyYW5zcG9ydCBmb3IgbGVnYWN5IGRldmljZXMuDQo+DQpZZXMgb25s
eSBsZWdhY3kgZW11bGF0aW9uIHdobyBkbyBub3QgY2FyZSBhYm91dCBoeXBlcnZpc29yIG1lZGlh
dGlvbi4NCiANCj4gQ2FuIGEgZHJpdmVyIHVzZSBib3RoIHRoZSBtb2Rlcm4gdHJhbnNwb3J0IGNv
bW1hbmRzIGFzIHdlbGwgYXMgdGhlIGxlZ2FjeQ0KPiB0cmFuc3BvcnQgY29tbWFuZHM/DQpIYXJk
IHRvIGFuc3dlciwgSSBsaWtlbHkgZG8gbm90IHVuZGVyc3RhbmQgYXMgZHJpdmVyIG5hbWVzcGFj
ZSBpcyB1bmNsZWFyLg0KTGV0IG1lIHRyeS4NCg0KQSBtb2Rlcm4gZHJpdmVyIGluIGd1ZXN0IFZN
IGFjY2Vzc2luZyBhIHRyYW5zaXRpb25hbCBkZXZpY2UgaGFzIGl0cyBvd24gdHJhbnNwb3J0IHZx
IGZvciBzYXkgY29uZmlnIHNwYWNlIFJXLg0KVGhpcyB0cmFuc3BvcnQgcXVldWUgY2FuIGRpcmVj
dGx5IHJlYWNoIHRvIHRoZSBkZXZpY2Ugd2l0aG91dCBoeXBlcnZpc29yIG1lZGlhdGlvbiwgLSB5
ZXMuDQpTYW1lIGRldmljZSBpZiBhY2Nlc3NlZCB2aWEgc29tZSBsZWdhY3kgZ3Vlc3QgVk0gZHJp
dmVyLCBpdCB3aWxsIGdldHMgaXRzIGNvbmZpZyBzcGFjZSBhY2Nlc3NlZCB2aWEgdHJhbnNwb3J0
IFZRIChBVlEpIG9mIHRoZSBoeXBlcnZpc29yIFBGIEFRLg0K

