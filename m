Return-Path: <virtio-dev-return-12269-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0751AC77B72
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 01:37:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3B0621318C7
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 01:37:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2E066986422
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 01:37:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 172D0986408; Tue, 18 Apr 2023 01:37:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 02EBC9863E1;
	Tue, 18 Apr 2023 01:37:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1f7LgwswQ243LIuwjDYgzQeQ4SrQ/bsPE7bORn2zGcnt9OK1+Kv6MAxTitrWcm5GGA+oFQWdjIXfqCLq3xwftvnrjmiFyfvlLxfN2ZbzoWWWMrGqfc8s89KLILYTVxDx80LNe21e6jGLDTY8VBza/BodxWXTMeNK5MOeAL9HvxWiuCCDHvO55BETVrpegXavEc/2n29dBlGQCAFArCgatrohGo2saOqebjz6qZDXYCmQf5Z2Ts4z/wlpzSc3TFymVQXeiRKiX8bikQ/TzBK5ZsqUu19ub+xx4ukCIz15m+7eng8ckUwkK2NNzab05NkUItvOvDi48+lUiTyxENSLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83ra06xE0JRMfKFmQI+8T1Q4CBXUJMK7uJMhxtUr28k=;
 b=JDN3T7LEApzmRJCjRXPjXgcap1APjXRh6TRA/ZE4Ax6bCPGyfZ/hakDEmzSKi706pQso85HCP4kZ6DoGBMr/Ed62u9SG5jOmwR0EqXJ+rISDV5kcu65gN1cSP8P73MDG6Bw2Kre5h3EjuI0OyDxg8m16PSVb9TQBhf1RwVUzhOagUP5r5vFWOpkpYb46gqEMx+svfTp+1gmvbRSzy3TRVmiqjZjFVTPbBYVGA/485qSc4DryyAMFJSMUFzVCAid7NMC9+1COHy1L9zY+h+BXffxLyBtwwBkE2c4nhV6+Z3IHHEREeMkLqiY1KaXjTdC/SoFhhEcf08efcqmnSaKXCg==
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
 AQHZY1tLAUtRpuZtUUOucQPGJlFfkK8flpUAgAQ7nwCAAE6hgIAAAXwAgAAFegCAAAt0AIAALl6AgAEOIwCAAFEgAIAAIPWAgAAcJ4CAASFtgIAABJ4AgAAKJYCAAACFsIAABgyAgAAAT3CAAAYpAIAAAJIAgAAJz4CAAILBcIAAxPiAgAAc1wCAABy4gIAAzAAAgAA85gCAAABI8IAAXS4AgAAARpCAAEh7AIADk47QgAB4NoCAAVIGkIAAil6AgAAHLYA=
Date: Tue, 18 Apr 2023 01:37:25 +0000
Message-ID:
 <PH0PR12MB5481BBEEBAEEBFC9F7FEB40BDC9D9@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <CACGkMEuNOYOxvcSzrs0UFEyk+xOkGUpOfhK8rOy_Mebz5b5wdg@mail.gmail.com>
 <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com>
 <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
 <f9f01f9d-f6ec-0daa-a11d-c75589dcbe6c@nvidia.com>
 <20230413163216-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818B39801152ECBA138E73DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMKqzN3E9S-pusTr=doYRtDvTZUie2PrygzPiH0p5fvg@mail.gmail.com>
 <PH0PR12MB5481EEEE5BFE68CDC6628455DC999@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230414025523-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F9D94282F794E0A08BF0DC9F9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230416163929-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AD9D5B6052C39A946AADDC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvV-2P4-7JzrDNCNzasG_S6pTYw==OZRd-dcsENL2aYzg@mail.gmail.com>
In-Reply-To:
 <CACGkMEvV-2P4-7JzrDNCNzasG_S6pTYw==OZRd-dcsENL2aYzg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW6PR12MB8958:EE_
x-ms-office365-filtering-correlation-id: f32bbc9d-42c1-42f4-832b-08db3fad76ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 V2kUH7CSnkzqPXjmtlNfTLwuCiv/f64i81JuRsqAogSDKBNoAAYJZpX8ghNcEKwUymJXSm8uDYeefc1LdSur3uasVez3ge9D6CYurLzTFWAnxZ2ckcHbkbqdzf9JUb61wpNO67aKM09L64Y/o+Oz+HZsYJL7RelpvLx0Bs4Cmqr/CWkMDOouhK0uOXxup3By8kjDapyE0XRx5JrZtXkFooGJRGtALKAEeAQ/S1I0JZ12ZDcWIzzn2zspL0d78ppVWq6Gz1vVw3jsycsybxmKG8vkuYH4Hj/nd61Als1hJCqY0HjWBaOjDasTE1dObuQEPUTolo3MfuaCTgKEnmW0oAKVOb+XGcuG6xWdWAn3vRc6z2a5YyOKzt0//rRsYn3HcUfhXGSH6WAOqAcnJkew2a7wvwTQN6zMTx/bIMuKb43qN8u4yOFeUXw/07hj93xkf+2xZN+dAXtnCLvvsJ+068xiLeCT96OwHOLCo+668bM9HD0sSZpQM729o2JydiAFw38aimfeXrqoGM35+TeyX9bU2W2Ob3Qu0c+rxzlDdtwmgTZAO8JDHdU2KQEawbKtpZJEH1jr3eH7w5V3tdiWBN4TLmYOfG/ZlPaFOasI3NzgvoiL3LsJANDF574Jsd2e
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199021)(478600001)(71200400001)(38100700002)(8936002)(8676002)(316002)(41300700001)(6916009)(4326008)(55016003)(76116006)(66446008)(66556008)(66946007)(54906003)(122000001)(66476007)(186003)(4744005)(2906002)(38070700005)(26005)(64756008)(9686003)(6506007)(86362001)(83380400001)(33656002)(5660300002)(52536014)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c2sxRGVuVFJPUlJqTkh0VnJON1NrQ3p6NFMxM2p4enQ2eDhMSmJseXZFRkU2?=
 =?utf-8?B?dzFQdEdJaXh4V0FVTEw5L2FRVVZ1TkJnYWpnOTFVMDdkVUFzRWNmVDc2bGw2?=
 =?utf-8?B?dSt3TU5ETkpWYkVUbjdKbTdtTzJlY2xxcUxibTJOdnA0cEFPRmFUWldtSDcx?=
 =?utf-8?B?NzJtNW9oaWJ6eElOdWt2OGpQbktpb2g3ZDkrNWFpdTdhQytpU1RLM3FWZWVh?=
 =?utf-8?B?bmZBdmxXZTRlV2orK25xdWtQa0ZrVzQram1wazVLbk81LzJ6ZEl1VDBFaHVF?=
 =?utf-8?B?VmU5ZFloVUJDYjBDWlBuSVpMcXc1TkNmQ0t6VW5XOUVSTzdpMTJ2cHJZQkdv?=
 =?utf-8?B?UXpGV3Q3Z29iUDdEWk9XYjd4VXRqa2NpVzBmTmRLbTROWDR2b1pkWUFNWGZj?=
 =?utf-8?B?SU1EMWp0blYxcHcway9YbDNEQ2s3WUppeU1CNHBxRlgvU1MxMURhZng0bG0z?=
 =?utf-8?B?TGFXb0hJcjg3TFNNN1dhL0wvTkI3UWtpeWZNMUlvS2ZhNlpoaUNIWDVMSk43?=
 =?utf-8?B?SVFvZmtFYkI3QTJNb2s0eWhGN3JUdXVoTUxSSVlZYmlDQnhYem9zOFQ2OWJK?=
 =?utf-8?B?N1hsUzZqY1BPcmg3MFNoUW5FRGhTMDA0dTFlMmY4UU1tblhuaU85ZFJUNEE2?=
 =?utf-8?B?K3o5aWlrTzNmZWxVUmJlQjY3dFJkQnQ3UWZXRXFHNkpFbGpXOGhrNzNSM2Iy?=
 =?utf-8?B?aHpqcDdYWi9PaEo3MUFhQmNrSTdiU3kxK3pwYUZ2V2Y4TUhTbmdqL1FEdmNl?=
 =?utf-8?B?OVJtR0ZZQXRBRXdEcEgvSzRud3RTdE9jRllOS2xuYWdiUEthamhaVmZQRDlH?=
 =?utf-8?B?R1hIWDV1TnJwOUFWcGtTSzdhQXh5dEhPbE1jOHdtMGZoL29abjRFLzVtK3RB?=
 =?utf-8?B?NFlPbDIwODd1ZEZMZlBrdXJlUVVGRHhZbC9BVElpd1FjbDhjcGhUMmtFSnFW?=
 =?utf-8?B?WXBpSTBYQllNTzJjNEo2dlpEQ0tMUDd3djU0L3Mxa3AwVjBjdm40QXd6K3Zm?=
 =?utf-8?B?RkVjQ0JtOE5RMlRXN3h6QzVYQTQrN3JROTRzbDJYUitVKy9HYmJmNW1yQk5z?=
 =?utf-8?B?UWN0Y0ZsTkdITngwMVRIU1JuR0d2Tm1ZR29ZMzlIYy9uUlB4Q3RpcE0xWERs?=
 =?utf-8?B?U1E5U1d6ZWR5WW9zejZoT1k1RW03QW43QmFOVU1hd1dXa01xRUxvVW5JT2V4?=
 =?utf-8?B?Z0JlUTZmd3I3RG9OSGFiOE9ObUNDYWxrUWhpWVJhbXlSY1U2aE5JMEo3WWE0?=
 =?utf-8?B?c290TEJDMlE5VndYcGQzdHQ2MDJjR3UxZUE1TVV6S3V2Z2JKRTcvbDJzNjhh?=
 =?utf-8?B?YlVpMDVUOFcwRzc1MTg3d1FFaGN1Z2dSc0pHWmFTNDRYb1pmWHhFeW9nMmU5?=
 =?utf-8?B?NFpKMkx3R3FvemwrL3NwRmtoZFlJS1JVME15aHJSamtNZmE1SmxmNU4waXlC?=
 =?utf-8?B?USttY0hIVVpJaGtERlM5eVM5UDdNZ2dEUlB4d0kvV1padG14bW8zdXBHb2dY?=
 =?utf-8?B?dDVQRWt4eXBBaTNRYUtqdGVxUC9kVEp1OUxaL2ZUdFBDZFBLWmZCWDhGM29M?=
 =?utf-8?B?TCtMRkpQU0N1VjI1cEJYSEp1Mzh0bGJKeFBFbEMvT2F6RmJxUjhibXR3QmZK?=
 =?utf-8?B?dnJoUXpIVUkvOEdTSVl6VW1CMUdzaVFybmw1VStZYjJLV3hVR2dJRXlpYytT?=
 =?utf-8?B?MCtPZWxLYU5LaU8ydWwxZTVQRTA4M05scndwT2haRHcxVnJDeTB4UVJodWpq?=
 =?utf-8?B?NExsaGFoczBaQ0tFb2d5WW13cVQ0a0hnNk1mcFI3VTBaaVFyb0txVUVKeDZK?=
 =?utf-8?B?SVNESExhWmRxYWZibnVqYkdMT3lWVjhobzNzUDE5KzFKUFV2U2JvTGpsMlhh?=
 =?utf-8?B?SFlqSWVWZnJ6cWFRL3pXY1pFVFZ3Q2dmY1g3TzN2U1dSdTRORXUxSXVGWTUx?=
 =?utf-8?B?Ymg4bC9DSzU3QkhXemludncvR3M3TEI5UzRvQlZMMjlYQ1drdkpSNXB1Z2Ry?=
 =?utf-8?B?R2NabnhUd01VUXJ4NDhBU1lsdk16MmRpNlBOL1VqUlBWS0gzM0E5WnlTZExi?=
 =?utf-8?B?ZWU0OFFuTlZ6MHZYdTU1dnVzZkN2YUJhZW8ybXFldmE0Q2VaWjlUaWVrZGI5?=
 =?utf-8?Q?/dPA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f32bbc9d-42c1-42f4-832b-08db3fad76ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 01:37:25.5890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wr3z5M/bF+CuoANpbiFLSOOlLVuVfYFvvyY+A+BXGmPOODsEnoItn1TXN31/NN5NRbyfAUtj1HSF9oGY1hPw5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8958
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBBcHJpbCAxNywgMjAyMyA5OjA5IFBNDQoNCj4gTm90ZSB0aGF0IGN1cnJlbnQgdHJhbnNw
b3J0IHZpcnRxdWV1ZSBvbmx5IGFsbG93cyB0aGUgbm90aWZpY2F0aW9uIHZpYSBNTUlPLiBJdA0K
PiBpbnRyb2R1Y2VzIGEgY29tbWFuZCB0byBnZXQgdGhlIGFkZHJlc3Mgb2YgdGhlIG5vdGlmaWNh
dGlvbiBhcmVhLg0KPg0KTm90aWZpY2F0aW9ucyB2aWEgTU1JTyBpcyB0aGUgb2J2aW91cyBjaG9p
Y2UuDQpDb21tYW5kIGlzIGFsc28gZmluZSB0byBjb252ZXkgdGhhdC4NCkkgaGF2ZW7igJl0IHNl
ZW4gdGhlIHRyYW5zcG9ydCBWUSBwcm9wb3NhbC4NCkRvIHlvdSBoYXZlIHBvaW50ZXIgdG8gaXQ/
DQoNCg==

