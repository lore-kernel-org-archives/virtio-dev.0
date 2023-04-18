Return-Path: <virtio-dev-return-12270-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D6FC77B72
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 01:48:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D6FC02CAD4
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 01:48:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C658698661B
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 01:48:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B1F0A98641E; Tue, 18 Apr 2023 01:48:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8717D9863E1;
	Tue, 18 Apr 2023 01:48:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZA9KdyBhfvpacBRfbAsAMM5Eq3gn5pqXP3wck1rA1mrbhhEFcUdmw6AG3hqkXILE3QsQmuBd7f3PreqtH0h5QkFRQ+y0Oi5O9MgSud15bH64ADituMbjEBtIWk7eAjPJMKGu/ho7gW43E+Ubw2IwGPNoUeBJG8YGiIxtkuVyRcf1AbxnDu4EYnyI6zj/4kBwmgan1AU8MuUvIeTCLtwDyuNPz1ppxXmCZ+nEHYq2B8xRzaAKbvI8wMA+PSppiHu9Ys9xsnyjS+3TQb4xEB1qwokNR5QIPn16SC1Yk1SDhaWXPo2Qfbb6VecTfEJjDgDSLxpIC5nGQ+Y6QDzM3xYu+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvCoR0dKmaZzWW97NoJfYt/emJ8P12hqFdYo9jFPBjE=;
 b=ARBfDBtisp5FjQ71XxBraYMhGTbKGKJbzTievGCCRO8/Wynhmzhyc+fXShSfMw0x7/GUmRD1zhW1aHCfId17ok+x3DTpwQ1zBxg6ThtWVmyQnkkRihjeZ1isbzJeoFcX89luXoo6SvA4kSolrYVFlyjEckgEYpJx0xci9JvleQpq7uCbmdwilvorJ3tOUnKGg65VRTRqAks5uLehtEOfqvlA42ExSm37xAVh+s71QcwPvVljQvA/63QtyNqWoadsJcwm9e5waDhNlb1Q1Y6PvPoM7587zi1H9BElQqMebp+GeCzoYzs51fNqScJNtVmLsdpsBr3vUGbQoY3BdS4oYQ==
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
 AQHZY1tLAUtRpuZtUUOucQPGJlFfkK8flpUAgAQ7nwCAAE6hgIAAAXwAgAAFegCAAAt0AIAALl6AgAEOIwCAAFEgAIAAIPWAgAAcJ4CAASFtgIAABJ4AgAAKJYCAAACFsIAABgyAgAAAT3CAAAYpAIAAAJIAgAAJz4CAAILBcIAAxPiAgAAc1wCAABy4gIAAyrIAgAAhEfCAAIO9gIAAAWdQgAAGhACAAACJcIAEsiqAgADky5CAAIY1gIAACj0Q
Date: Tue, 18 Apr 2023 01:48:35 +0000
Message-ID:
 <PH0PR12MB548197F82C97ED199880C79BDC9D9@PH0PR12MB5481.namprd12.prod.outlook.com>
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
 <PH0PR12MB5481C29561D5E48BA5D8AEEEDC999@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEseO=4xDA+pH2x=CaJ6XyzHEx1ZFO-+uevJH50kLeSWhA@mail.gmail.com>
 <PH0PR12MB5481FFC95F54AD048927FF12DC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEutqWiq7A76LcE+wDoS+81rgANBtxeccjw7JL4iLn3_gQ@mail.gmail.com>
In-Reply-To:
 <CACGkMEutqWiq7A76LcE+wDoS+81rgANBtxeccjw7JL4iLn3_gQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS7PR12MB6047:EE_
x-ms-office365-filtering-correlation-id: 7ca59101-248b-4e8f-8097-08db3faf062b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 i5HlN1OtZeTdVDS0USCZ15ygUb76eunfthDBZka1/FlJPSTVYzS2ikBTDxsdBXC3A2NZUwtMSS3ykhtZ8lBX7rt5jexKNBb/gTQZdiIc1iNqtM8wJDwsptMUXUASJTi6fjiJ19yzazBESOGhF9QDIIyE+OILM5a3I0SLyE2vTK9BJQB6p1PTzeuayb2ftGw/1LpDxu3fiyx3zeyXCc7w3F2LKZvFGQWnmz+V/6JDfGhgBmXkBxig4turYpic56KbCcZ77/P2vquWI5oHyZY3FjofDlmqpBc2OSDs6jKZCw0aiSFPhMSlZUQRrpeWY3BwDH2UuVr5Vltuq227sYxtb9vfmA9R1itwS2UR3daStRF/cLprMvvT7Yme/tFq9xJbFKX/L9JysT5N4GNGEGxBnaiWKMzUEfwB6gIN5kqJidXtC+rF3XOBvprOpQ9vCzTJLPcC5fFicvIngGlGBEZ4+1TiYqfRUl8GzXScW69ZXmidosq0veTiTgRg+tU0PBYbVkrXfsLyLIZ/zOqoIkf3YU944mCaoQcUsTg9X9TWJDZ0bR2u5YyptD1F20LyLUYbS4nl2YaY71gGXeVexCrbqXR26+J1jiv9ktRiqfeG1Stq9i8Fap6WO618pcnzLnOq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(33656002)(76116006)(4326008)(6916009)(54906003)(316002)(66446008)(64756008)(66946007)(66556008)(66476007)(71200400001)(7696005)(478600001)(41300700001)(5660300002)(8676002)(55016003)(8936002)(2906002)(52536014)(38070700005)(86362001)(122000001)(38100700002)(6506007)(9686003)(26005)(186003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b2U0YnBUa2U3aEJMa1lTaE9NRUZzNVZZT3BpOHNqbTBRK0V5cjBrV0J5dHc0?=
 =?utf-8?B?cUF3VmR2QWEvY2RxNklBQlc0b0V0VHBSVGdpRXMzanV1NCtFNVlEOGhXTXFX?=
 =?utf-8?B?YnhRV3c5b25qM1ZjOUI1S2IrZGFRQlM3d0QyRFNEOWU5c0dJRWwxVytSNi81?=
 =?utf-8?B?ZEVEa2pOVHBzdWFiMThlOE9xcUgrVVdhZnlDU2ZuYjhCUTNOaXpsVzEwcHlm?=
 =?utf-8?B?bkNoMW5BTnhsMWFHYjRvYUdhOTIvNzdJNEpsRkJTV254Tk1OeUFWclFuLzd4?=
 =?utf-8?B?cnNJQWdlSjIxajNhbnB1czRLOHBtaXBQcnovbGdCWDgxUXZpZ0lRbW9Uejhw?=
 =?utf-8?B?anM2T2cyWUxGVEdHWGxaUktxMFJTZjFSNS84dCtYWWFEVTZ5UzJPM3J0Si9N?=
 =?utf-8?B?UWdDWEdlWnhzRG5FWkZjNHlQNUhNSUk4VGNzVjBQSmFodkZ3dmRURGZQRllw?=
 =?utf-8?B?L3dGbXlyM2lmb2pBVDRoWjIwZzJEQVRqMkV5WVV5TmgwTVNETmxuOXhTTWh5?=
 =?utf-8?B?YmNWdjhEdDBOV1FGckpRQ3BzanROamFpdlRMcjZ0SlJyWkhGNTF6c1lrQTY3?=
 =?utf-8?B?ZkZaQ0xuM1dRSnpGN3UyNk4xLyt5RFhnczJFUUVqRmpMMkRmdkFzZUVPTStT?=
 =?utf-8?B?UWxqNk9FdE90OXNERU5TSzJyMVU1MWpYL3NjZWRHVkN0UisraEYxOFJKc3A3?=
 =?utf-8?B?d3RONTY1TnREbUhlNS8xSHBNcjV5cTJpNTAvWUVSa0ZaTGtuUkVEa0lRSkhu?=
 =?utf-8?B?Mmc3TkFWZjhBNXRZK2Zzb3BhdENLc0NPZnNQMDM1RUF1aXlSQmRuWkYyTUF5?=
 =?utf-8?B?dWJCTlNDVUxQVWZGeHdvMTZqL2FuWGd2NkxrcTVvQlhLWEJCZDBIS0Z4aWsx?=
 =?utf-8?B?ak9OVHBpdXZGYlBWeWt6NVZKTjlqNUFSdzY1bjNwQkVhNFd6YTBnUWljWm1O?=
 =?utf-8?B?MEVjT2gvL2Mzc0UzeUZ3NVNCeXRFWURaQlZTNjdBUHlqcVpKR3JYKy9YSjdU?=
 =?utf-8?B?Z1E1LzJ6WXpvVEg5VlBxZGVxTDBTWURyVVBwTzhqaTc5b2xjOE1TTWk0bkht?=
 =?utf-8?B?WnJYT2lWUnZJUVNIMWN6c2N4NG16S2lhLzZuMXRCRzZKcFJBTFNYM2dYc3ZU?=
 =?utf-8?B?RmZjQXVyeEZDK0sycTA0bDRwNG1nTVhPZHcvc3lZSUQwWFY0QVRpdHZHa3A5?=
 =?utf-8?B?eHlwaWEwbVUrcjE1OTVsR3kzamc3RHU5V2RMb1lnYmF0ejBKa0x1RHNodjYw?=
 =?utf-8?B?aU5QSTNReVNKclpCdFhmc3JRS0V2bStzOHdxcjdoVUpueU9KVGxOVkRmdGZW?=
 =?utf-8?B?WlptbWFBWGNYNCtrQ3NMTExJR2RiK0k4SG9uR1NBUkExd3VUMWpzNWIwMWdD?=
 =?utf-8?B?L0VNUDFpcUxEcGNNbVBOczVQRENFZzFyM0txSXdheEprMTlDTlRza3pHd0pS?=
 =?utf-8?B?MEZIWnhoUkhIQ2V3M2E4TG9GZ0ZhOHM1NlBqaXF3NXp2am42ZVdMdm1VTHR5?=
 =?utf-8?B?STN2RU9aMFBUS0V0OE9abWhzd2lMOUczMnpzcCtoajFRVjEzWnVRRFdsMjNO?=
 =?utf-8?B?WTB0cEF3aWFrMUdKOUF3SHVKeHhCQWVHdTBxRHRHWHd0b0Z1RVFmZGgyMncx?=
 =?utf-8?B?bWhCWWs1MXg5L1l1S3RHSGNld2l4NjhlZDhYR2NzL0RJMnpBTjdqaFZiTVpU?=
 =?utf-8?B?bG42K0NOU3hYazdXbGowRGxEODhzcTZITnorYnAyNTVTTUh1ZUwwcTVyZE9z?=
 =?utf-8?B?R0RXcG5qV3ZTNHU2RXlHK250OU0zeWJHRGNQR0c4KzRQbkpLamxSOVplS05k?=
 =?utf-8?B?NTdJaVd6b1Z0c0hnYitSTkFFdmVNak5WOU1IUFBERXJ4WWlVc014VjMxWENw?=
 =?utf-8?B?bEpwU1E5TWVQMStXaWkrN29NcGxWazRMSXNZMzhENjBnUmRRVENLV2QzUHJw?=
 =?utf-8?B?eENzeU9PK2EyTHE1SmY2b3ZrUGhBSUxDaWkyOVhaTlQxb2ZzbTVCK3ppdTVi?=
 =?utf-8?B?N21UWXdZaEplOWZKMkl3V2hKKzRJVXhBU2orOEhZNWR1SWR2UlVtR0FoYnBF?=
 =?utf-8?B?OWM5Z2o3VHh2WVlRWk5sdVpMWXlJbU11Q3VSWUpYNXQxZXVtam1uZjRqR1U5?=
 =?utf-8?Q?jY+U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca59101-248b-4e8f-8097-08db3faf062b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 01:48:35.8013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kcPvmUP6QO/B6KXdb2jawVR4R7Pf5lZl8ygcE4xlrWCXdiJDKzS3nqpDqcrIlo8XdndoQFTtyEG+xhluzhYh4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6047
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBBcHJpbCAxNywgMjAyMyA5OjAyIFBNDQo+IA0KPiA+IElzbid0IHRoZSBzaXplIG9mIEJB
UiBhbmQgaXRzIGNhcF9sZW4gZXhwb3NlZCBieSB0aGUgZGV2aWNlPw0KPiANCj4gU29tZWhvdywg
aXQncyBtb3JlIGFib3V0IGhvdyB0aGUgaHlwZXJ2aXNvciBpcyBnb2luZyB0byB1c2UgdGhpcywg
bWVtb3J5DQo+IG1hcHBlZCBvciB0cmFwcGluZy4gRm9yIGVpdGhlciBjYXNlLCB0aGUgaHlwZXJ2
aXNvciBuZWVkcyB0byBoYXZlIHZpcnRpbw0KPiBrbm93bGVkZ2UgaW4gb3JkZXIgdG8gZmluaXNo
IHRoaXMuDQo+DQpPay4NCg0KPiA+IFBDSSBCQVIgc2l6ZSBvZiB0aGUgVkYgY2FuIGxlYXJuIHRo
ZSBzeXN0ZW0gcGFnZSBzaXplIGJlaW5nIGRpZmZlcmVudCBmb3IgeDg2DQo+ICg0SykgYW5kIGFy
bSAoNjRLKS4NCj4gPiBQQ0kgdHJhbnNwb3J0IHNlZW1zIHRvIHN1cHBvcnQgaXQuDQo+IA0KPiBZ
ZXMgdGhpcyBpcyBmb3IgU1ItSU9WIGJ1dCBub3QgZm9yIG90aGVyIGNhc2VzLiBXZSBjb3VsZCBp
bnZlbnQgbmV3IGZhY2lsaXRpZXMgZm9yDQo+IHN1cmUgYnV0IHRoZSBoeXBlcnZpc29yIGNhbiBu
b3QgaGF2ZSB0aGlzIGFzc3VtcHRpb24uDQo+DQpZZWFoLCBpdHMgbm90IGFzc3VtcHRpb24uDQog
DQoNCj4gPiA+IGFzc3VtaW5nIHlvdSBoYXZlIHR3byBnZW5lcmF0aW9ucyBvZiBkZXZpY2UNCj4g
PiA+DQo+ID4gPiBnZW4xOiBmZWF0dXJlcyB4LHkNCj4gPiA+IGdlbjI6IGZlYXR1cmVzIHgseSx6
DQo+ID4gPg0KPiA+ID4gWW91IHdvbid0IGJlIGFibGUgdG8gZG8gbWlncmF0aW9uIGJldHdlZW4g
Z2VuMSBhbmQgZ2VuMiB3aXRob3V0DQo+IG1lZGlhdGlvbi4NCj4gPiBHZW4xIGNhbiBlYXNpbHkg
bWlncmF0ZSB0byBnZW4yLCBiZWNhdXNlIGdlbjEgaGFzIHNtYWxsZXIgc3Vic2V0IHRoYW4gZ2Vu
Mi4NCj4gPiBXaGVuIGdlbjIgZGV2aWNlIGlzIGNvbXBvc2VkLCBmZWF0dXJlIHogaXMgZGlzYWJs
ZWQuDQo+IA0KPiBTdXJlLCBidXQgdGhpcyByZXF1aXJlcyBhIGxvdCBvZiBmZWF0dXJlcyB0aGF0
IGRvIG5vdCBleGlzdCBpbiB0aGUgc3BlYy4gRS5nIGl0DQo+IGFzc3VtZXMgdGhlIGRldmljZSBj
b3VsZCBiZSBjb21wb3NlZCBvbiBkZW1hbmQgd2hpY2ggc2VlbXMgdG8gZml0IHRoZSBpZGVhDQo+
IG9mIHRyYW5zcG9ydCB2aXJ0cXVldWUuIA0KSSBkb27igJl0IHNlZSBob3cgdHJhbnNwb3J0IHZx
IGlzIHJlbGF0ZWQuDQpBIGRldmljZSBjb3VsZCBiZSBjb21wb3NlZCBhcyBQQ0kgVkYsIFBDSSBT
SU9WIG9yIHNvbWV0aGluZyBlbHNlLg0KVW5kZXJseWluZyB0cmFuc3BvcnQgd2lsbCB0ZWxsIGhv
dyBpdCBpcyBjb21wb3NlZC4NCk1heSBiZSB1bmRlcmx5aW5nIHRyYW5zcG9ydCBpcyBhIHRyYW5z
cG9ydCBWUSwgYnV0IHRoYXQgaXMgbm90IHRoZSBvbmx5IHRyYW5zcG9ydC4NCg0KPiBTbyBpdCBh
ZGRzIGRlcGVuZGVuY2llcyBmb3IgbWlncmF0aW9uIHdoZXJlIGEgc2ltcGxlDQo+IG1lZGlhdGlv
biBjb3VsZCBiZSB1c2VkIHRvIHNvbHZlIHRoaXMgd2l0aG91dCBib3RoZXJpbmcgdGhlIHNwZWMu
DQo+DQpNZWRpYXRpb24gb2YgUEYgYW5kIGh5cGVydmlzb3IgaXMgbm90IGVuY291cmFnZWQgYW55
bW9yZSBhcyB3ZSBtb3ZlIHRvd2FyZHMgdGhlIENDLg0KU28gbWF5IGJlIHNvbWUgc3lzdGVtIHdp
bGwgZG8sIGJ1dCBhcyB3ZSBoYXZlIHRoZSBQQ0kgVkZzLCB0aGVyZSBpcyBjbGVhciBuZWVkIGZv
ciBub24tbWVkaWF0ZWQgMS54IGRldmljZXMgZm9yIHN1Y2ggZ3Vlc3QgVk1zLg0KRm9yIGxlZ2Fj
eSBrZXJuZWwgbWVkaWF0aW9uIGlzIGFjY2VwdGFibGUgYXMgdGhlcmUgaXMgbm8gQ0MgaW5mcmFz
dHJ1Y3R1cmUgaW4gcGxhY2Ugb24gb2xkZXIgc3lzdGVtcy4NCiANCj4gPg0KPiA+IEdlbjIgdG8g
Z2VuMSBtaWdyYXRpb24gY2FuIGRvIHNvZnR3YXJlLWJhc2VkIG1pZ3JhdGlvbiBhbnl3YXkgb3Ig
dGhyb3VnaA0KPiBtZWRpYXRpb24uDQo+ID4gQnV0IGJlY2F1c2UgZ2VuMiBtYXkgbmVlZCB0byBt
aWdyYXRlIHRvIGdlbjEsIGhlbmNlIGdlbjIgdG8gZ2VuMiBtaWdyYXRpb24NCj4gYWxzbyBzaG91
bGQgYmUgZG9uZSB0aHJvdWdoIG1lZGlhdGlvbiwgZG9lc27igJl0IG1ha2Ugc2Vuc2UgdG8gbWUu
DQo+IA0KPiBJdCByZWFsbHkgZGVwZW5kcyBvbiB0aGUgZGVzaWduOg0KPiANCj4gMSkgaWYgeW91
IHdhbnQgdG8gZXhwb3NlIGFueSBmZWF0dXJlcyB0aGF0IGlzIGRvbmUgYnkgYWRtaW4gdmlydHF1
ZXVlIHRvIGENCj4gZ3Vlc3QsIG1lZGlhdGlvbiBpcyBhIG11c3QgKGUuZyBpZiB5b3Ugd2FudCBk
byBsaXZlIG1pZ3JhdGlvbiBmb3INCj4gTDEpDQo+IDIpIG1lZGlhdGlvbiBpcyBhIG11c3QgZm9y
IHRoZSBpZGVhIG9mIHRyYW5zcG9ydCB2aXJ0cXVldWUNCj4NClllcy4gU28gYm90aCB0cmFuc3Bv
cnQgb3B0aW9ucyBhcmUgdGhlcmUuDQpBIFBDSSBWRiB0aGF0IGRvZXNu4oCZdCBsZWdhY3kgYmFn
Z2FnZSB3aWxsIGJlIGp1c3QgZmluZSB3aXRob3V0IGEgbWVkaWF0aW9uLg0KRm9yIHNvbWUgcmVh
c29uLCBpZiBvbmUgd2FudHMgdG8gaGF2ZSBtZWRpYXRpb24sIG1heSBiZSB0aGVyZSBpcyBzb21l
IG9wdGlvbiBvZiBzdWNoIG5ldyB0cmFuc3BvcnQuDQpCdXQgc3VjaCB0cmFuc3BvcnQgY2Fubm90
IGJlIHRoZSBvbmx5IHRyYW5zcG9ydC4NCiANCj4gPiA+IFNvIGFzIG1lbnRpb25lZCBpbiBhbm90
aGVyIHRocmVhZCwgdGhpcyBpcyBhIFBDSSBzcGVjaWZpYyBzb2x1dGlvbjoNCj4gPiA+DQo+ID4g
PiAxKSBmZWF0dXJlIGFuZCBjb25maWcgYXJlIGJhc2ljIHZpcnRpbyBmYWNpbGl0eQ0KPiA+ID4g
MikgY2FwYWJpbGl0eSBpcyBub3QgYnV0IHNwZWNpZmljIHRvIFBDSSB0cmFuc3BvcnQNCj4gPiA+
DQo+ID4gU28gYW55IExNIHNvbHV0aW9uIHdpbGwgaGF2ZSB0cmFuc3BvcnQgc3BlY2lmaWMgY2hl
Y2tzIGFuZCB2aXJ0aW8gbGV2ZWwgY2hlY2tzLg0KPiANCj4gU28gaGVyZSdzIHRoZSBtb2RlbCB0
aGF0IGlzIHVzZWQgYnkgUWVtdSBjdXJyZW50bHk6DQo+IA0KPiAxKSBEZXZpY2UgaXMgZW11bGF0
ZWQsIGl0J3MgdGhlIGNoYXJnZSBvZiB0aGUgbGlidmlydCB0byBsYXVuY2ggUWVtdSBhbmQgcHJl
c2VudA0KPiBhIHN0YWJsZSBBQkkgZm9yIGd1ZXN0cy4NCj4gMikgRGF0YXBhdGggZG9lc24ndCBu
ZWVkIHRvIGNhcmUgYWJvdXQgdGhlIGhhcmR3YXJlIGRldGFpbHMgc2luY2UgdGhlDQo+IGhhcmR3
YXJlIGxheW91dCBpcyBpbnZpc2libGUgZnJvbSBndWVzdA0KPiANCj4gWW91IGNhbiBzZWUsIGl0
J3MgbW9yZSB0aGFuIHN1ZmZpY2llbnQgZm9yIGxpYnZpcnQgdG8gY2hlY2sgZmVhdHVyZXMvY29u
ZmlnIHNwYWNlLA0KPiBpdCBkb2Vzbid0IG5lZWQgdG8gY2FyZSBhYm91dCB0aGUgaGFyZHdhcmUg
QkFSIGxheW91dC4gTWlncmF0aW9uIGlzIG11Y2gNCj4gZWFzaWVyIGluIHRoaXMgd2F5LiBBbmQg
d2UgY2FuIHVzZSB0cmFuc3BvcnQgb3RoZXIgdGhhbiBQQ0kgaW4gdGhlIGd1ZXN0IGluIHRoaXMN
Cj4gY2FzZSBmb3IgbGl2ZSBtaWdyYXRpb24uDQo+DQpTdXJlIHdvcmtzIGluIHNvbWUgdXNlIGNh
c2VzLg0KQnV0IGl0IGlzIG5vdCB0aGUgb25seSB3YXkgdG8gb3BlcmF0ZSBpdCBhcyBJIGV4cGxh
aW5lZCBhYm92ZSB3aGVyZSB0aGVyZSBpcyByZXF1aXJlbWVudCB0byBub3QgaGF2ZSBtZWRpYXRp
b24gZm9yIG5vbl9sZWdhY3kgaW50ZXJmYWNlLg0KDQo+ID4gU29sdXRpb24gbmVlZHMgdG8gY292
ZXIgdHJhbnNwb3J0IGFzIHdlbGwgYXMgdHJhbnNwb3J0IGlzIGludGVncmFsIHBhcnQgb2YgdGhl
DQo+IHZpcnRpbyBzcGVjLg0KPiA+IEVhY2ggdHJhbnNwb3J0IGxheWVyIHdpbGwgaW1wbGVtZW50
IGZlYXR1cmUvY29uZmlnL2NhcCBpbiBpdHMgb3duIHdheS4NCj4gDQo+IElmIHdlIGNhbiBhdm9p
ZCB0aG9zZSBoYXJkd2FyZSBkZXRhaWxzIHRvIGJlIGNoZWNrZWQsIHdlIHNob3VsZCBub3QgZ28g
Zm9yDQo+IHRoYXQuIEl0J3MgYSBncmVhdCBlYXNlIG9mIHRoZSBtYW5hZ2VtZW50IGxheWVyLg0K
VGhvc2UgYXJlIG1haW5seSBSTyBjaGVja3MgYW5kIGNoZWFwIHRvby4gSXQgbGFyZ2VseSBkb2Vz
IG5vdCBpbnZvbHZlZCBpbiB0aGUgTE0gb3IgZGF0YSBwYXRoIGZsb3cgZWl0aGVyLg0K

