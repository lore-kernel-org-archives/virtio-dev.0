Return-Path: <virtio-dev-return-12915-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0CDC7EE29
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 02:58:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C00252B038
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 02:58:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B83D39866A3
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 02:58:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AC5FD98668D; Fri,  9 Jun 2023 02:58:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 972E198668E;
	Fri,  9 Jun 2023 02:58:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlPlJ/pM38eqSELPgSZjLW33zv7vXAjet01VWBCSHbIwbP4cfeVDgTo+fDi5nsp6nR5WEf/1O16E10+A/JIxiWBH6+d+qy4rw6FsTbBm8qQRKW4uKSsO9oZTB5zNNh7/2k4apDlhRZhwtvzUJJ9DvByPLXXhTB5doatklbguPCzkfOMm56mYOjkEMIemHHo/shYUwYg61WCL6PLQmXNw8Ng94KE8yQuy9cOmuK9RdGRH/Z85nWPEYPvrEa7Oaqe3VbaULCLfCmwVMdDp9zypsqMrX7OcHOnQJf1CjPTIzvvz3O9Eb/TVDxn8jS5jCx9c710QWVTeTvNhS/hMlJsu3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xw7nvkAw38m1cKIwlf8i1pwcjDR0sHIsE7cwPwKe9bI=;
 b=m0EQASCoFVxukjowRDRwCubL3ru7iGWCnVipirnQp5z3D3Dp7dN073jqD65ko55Jv0pTaJGln8xnPE1zKkJWdaFerH1hpUO33nzQpsql8z/D3PGonDt8mp5p+DqXTMOcMb7mvAXHGRnRrlzwo07kJZ3x7OASe6RaeaZxFQuzLpLLRVOSS3vd5oPYc4quJ+QzRVg8B5nXNBh/vKuBfpcpJMO+vn6pTCTNFPfEqOt8MbKpP88tDg3A3QKbkOSR2LFlACLQgAjO796rqb8lBVOc736rNomIqutTuSid1AWj1JZkV25QhE/+8YBhsJicdgsIU3QSZ67NolrjQlbZVUONgw==
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
Thread-Topic: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3 0/3]
 transport-pci: Introduce legacy registers access using AQ
Thread-Index:
 AQHZlZHqSKW+Shm580CRlUjcCTH7qK96p2iAgAAAjkCAAAV4gIAAAhyAgAAFe4CAAALHYIAABcIAgAAChLCAAHFxgIAAHa6ggABpWICAAHwV4IAACZWAgAAiwLCAAGU9gIAAAqIggADn3oCAAPNNAIAACTvQgABBawCAAhKfIIAAwayAgAAF5ECAAAQjAIAAAcxggAACF4CAAAAyYA==
Date: Fri, 9 Jun 2023 02:58:22 +0000
Message-ID:
 <PH0PR12MB5481F1BE96B1CE71F4FBD2D8DC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230604105027-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B721C34D85D63FCC1F3DDC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604174224-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481DABA25CA36A5460B13E5DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605014539-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C14D65D5E10CD23A9F67DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605092859-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CEB3A34AAB49A282F2A8DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605174755-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548180E16376862A3C0DFF1DDC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230606073544-mutt-send-email-mst@kernel.org>
 <CACGkMEv1so_KGwJZG3GnAf=JNky7+BMNK7N4NTtucDS+WyW5VA@mail.gmail.com>
 <PH0PR12MB5481D80A48F3BD82D86B3DB0DC53A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsVrqCGJJ2Q5OGbgPdtEJHTpvVt6nEKP_MzkSH_-cOa6w@mail.gmail.com>
 <PH0PR12MB54810313CA6DD1995F52745DDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsy=pG=LT0hOT-PO3HTkk3NOAu6qA_GaZpKwqq8B996cA@mail.gmail.com>
 <PH0PR12MB5481B197049376E7C4D0112EDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsPjwgx=atOC1ww+RnfJcrg7m2CmMXWQCCoreCwsWVpLg@mail.gmail.com>
 <PH0PR12MB54817C027CB2B7BB74BD35EDDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsGA4ZhOPn5OCTZEZkja2UrLpJ8DXH+d62Fp5rtdicseg@mail.gmail.com>
In-Reply-To:
 <CACGkMEsGA4ZhOPn5OCTZEZkja2UrLpJ8DXH+d62Fp5rtdicseg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB5150:EE_
x-ms-office365-filtering-correlation-id: 3a8dd5cd-4bff-4930-6a3f-08db68956355
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 oju1se2GWethlhjH1tSytNQH6LI6IzYwZYG+9SVAx8Rxd74gSJ4XBMjKjT2/cnIZxCbqfLy7Fr47BPqEHB4hs7R5uaQm8j3sn82YXMUcVTSlewoT/6CSYeWQL+43uIiHHGIdFkv/QWs2a3RoaGX+HQiTYRGRr2n7uQpgJmuR5U/bXcjO7mC6qf7RMwxU0qnV9O3OgSiaolig2SlXJXglDdeWL1KzbvOS0h+8OhNnsVbteGktmSV8Bahi6+NqbfDaC5UdX0wihpGw2nukdzFpNkQC03r0+7nfCaOAIGafUu412uvwKqpxv89qbMlbjbXZF8HzwDR+1A18QqJhRFTKvKrcARsgFiDMgDwfSk+WgfkPRFdgtzr/+xU6dlryTyTbUtQiPgjC5twZvB+nylu+FMAY1+fW6IEgL2QULeQk+i/G6imngC9eg8O/zwwi5r87eUNFJsWzYfJz+kVP99hw0OuD08M9w+n3stYA61+M3FrVyAD3WViTmp8Ndwxss0EYY2jjzFGmlsRE4pN7QgfePNXXhEzkGscG4VmDUb1Zp7HglSSzSyxtUNwE5RL+nJ957pg5R1j3Z7Xvm9NgNUpia/EPF/KZLhgB0RCYYqs/mYy5pSERhL0TkXm1hGQIp7zY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199021)(107886003)(6506007)(26005)(9686003)(186003)(83380400001)(2906002)(4744005)(64756008)(76116006)(66556008)(122000001)(66446008)(66946007)(66476007)(7696005)(71200400001)(5660300002)(38070700005)(8936002)(38100700002)(8676002)(86362001)(52536014)(54906003)(55016003)(41300700001)(478600001)(316002)(33656002)(6916009)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?azlFeGg3ejYyY3lvSmVTVXI5TFRLT3FpVFhraTVKQkNzTlJOQklBREhpOVFV?=
 =?utf-8?B?VWwvNzR2N004cGZROEpUajVzR090c2xiZWlWbXF5aTVNWmNoSmdRZ3FKaFcy?=
 =?utf-8?B?VFF5SnMrdUxvKzA2cTBtbmZmK0ZHcklLczlqZUxCVER6eVRPS1AvSmczemRj?=
 =?utf-8?B?U2I0VnJBaVBSK2Uybmo3VERaNmJRcUlyeHNPZTlqbFhGQWlEVXR2MXJQdUYw?=
 =?utf-8?B?RTcydzh2dW1DNzFtSWQxS3d3VlZXT0FIUFZXK25JenljVjBBaU1DL2R0aXc1?=
 =?utf-8?B?eHJuRlZQRmhlMFJrSWEyOVE0RnB6N0RaVm03emFJUE01S1dmaE1OUFAyMmxF?=
 =?utf-8?B?cUwrNmJRS2NwUkE0V2Z4VDBlUDIrdlVXcFZCcmYyQWVPc2hSZG5XMmdWeS84?=
 =?utf-8?B?NkZTMC9ZR2o1ZXczcGNvSStsZUVZWVFVYUs3T05wWmg0VElHZy9qMCtvb1VM?=
 =?utf-8?B?U3pZMjd6Mk45RjlTL3pZWG51L0phZXAxWmsvZEtmOGM1SldtejJKOU9YUy96?=
 =?utf-8?B?Mi9WV2d1VlpEUmdneHV2SW5DckROSVc2VG5iMmxhRDMvRk83bm8ya0VyRW4w?=
 =?utf-8?B?NlRtVmUwQ3dKV2haZTRYSGlFeXBDbS82T0R4eUVvb2FLN2h6SC8rcUplV3BY?=
 =?utf-8?B?cUdsb0pTeXZROXBZcnpqMEpxcEdUc2oxT2xaZ01KVzlwUnFnd1ozNFh0UWsr?=
 =?utf-8?B?YXl1QjF6WlJpc3B4azYxd3hZODRId2YyR1Fuc1RQcHBRbWRldDlDT01mM3Vz?=
 =?utf-8?B?bHlTakNMc2VVbzVLN09UQmMwN2Zta2FQQ0tZRGN0QVlDQ1FsbG5hYnpnSFJR?=
 =?utf-8?B?Q3FTSUJmOE4vajFGZ0t0M2ZWdWN6V28waVlZME8zYmJMc2J6Z3dlR0cvYXVa?=
 =?utf-8?B?VFppR2hSeHlqd2pMQjdYN0YzK09DbWRYWk00STlwK2tnN2ZaNWRzR0M0bTRa?=
 =?utf-8?B?NGdSZHVCQnJYMkZvYm95SEpsYnVwblZadnJscUNwRzRPRTJ5ZXp4dVFKZDNE?=
 =?utf-8?B?L2liRURFMjdWNUlHczQ3bkxERXIwRzJuR2o2ZURYYlE1L3F0cTJzZ2pvK0VG?=
 =?utf-8?B?MHpPVTNPTGVidmNUTGtPZU14enp3a2MybnlDTEdSZG5VbnBtUEJUMXpNeFd5?=
 =?utf-8?B?TkhGRzRVeEluSkJDNW01TW1xTTJFbEo1NWJBemt0Ykc4N2Y0d3hiTUtYSlF2?=
 =?utf-8?B?RzNxNldhSks4cE9JWitvS2sya21SdVVwYUJtdDhVbVR1RlhyK3VnMEZsNDJH?=
 =?utf-8?B?bW5sblN4eC9xSXN5ZlZDS2hRdnozcmM1OE0wWHFBcExKR3NJQjVGOVRKVUpz?=
 =?utf-8?B?U2ZsVFUzUnkzTFdOV0lGVlo4V0dydVlBVGFsQVZSVm5qd3U4cXR5QlRTb1lz?=
 =?utf-8?B?anBTeEJESVhZTk53TTJvczYxMExBOUVwTTVNM2dKQ0dONCtFUWU3SVNoa3VV?=
 =?utf-8?B?S2orb0NwU2xndDJTbHZGeFhKNjFYTllRL0NwRG1RZ3VZMkpPeUhURFJZM0Vo?=
 =?utf-8?B?MnF3T3FBN3pYZTQ1b1VmQWRZWVgrT1ZxNFBFUnkvVHJiTDZpdGMyaG9RS1hC?=
 =?utf-8?B?ZUE2RVlFN2NsNTRNZE4wYktJb29MZTJLalZuNGh0a2d2SkZ6MmkxQ25KeXpL?=
 =?utf-8?B?VHg1bFczNUdzNHYvdkVWUldTU0oyWHlqam1ad2dubnNlREptRDNQOHdaSGVC?=
 =?utf-8?B?MmI2RkdMWHNrem1VdmFHV3RDV1pjdlEzSEU4MVZwL2U4MHhRSmRnSkdtQjRi?=
 =?utf-8?B?L1BkcDJ5bWhkaDB0blhYbko0RFNKWWxnME5BU09taEVDb1NyTktmOXhUa29n?=
 =?utf-8?B?ZFhhYytrNmxWU2ZiRlhmTjlKS3ZMNTI0dVJHK2pRSVZ6YVNyMlEwVlFSNi9C?=
 =?utf-8?B?eHJEWE5KN3hmRElLUHNzYUUza3JmVEtkVnp3TGtvTDB1WW1jeGdQVFdmbWE4?=
 =?utf-8?B?NkRnNlVlc0JpSU9NSFdrcTg5L1RWUTdVSVFoUE9HY3dkTmRDazV2d21NTXMy?=
 =?utf-8?B?SWxYeER6aWJsUUhWbUdIWVNSTm9kN0FvUVBIR0pJQ1hhZmQ3czJ2YW1zd0hN?=
 =?utf-8?B?ZklwTmxEWCtMRE5CSElTejNacFhWZHZLTmJpNUhYOG13YmFjak94L0QxRHhF?=
 =?utf-8?Q?bMbg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8dd5cd-4bff-4930-6a3f-08db68956355
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 02:58:22.8689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kf2vXxF5eD/nv0O679miPh+SDI9qXyGVu45sJN6iv74oaN6GeX1CWM2TXNq1ZkFBJSstRXjiCtnTWZO3GztaXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5150
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3 0/3]
 transport-pci: Introduce legacy registers access using AQ

DQo+IEZyb206IHZpcnRpby1jb21tZW50QGxpc3RzLm9hc2lzLW9wZW4ub3JnIDx2aXJ0aW8tY29t
bWVudEBsaXN0cy5vYXNpcy0NCj4gb3Blbi5vcmc+IE9uIEJlaGFsZiBPZiBKYXNvbiBXYW5nDQo+
IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDgsIDIwMjMgMTA6NTcgUE0NCg0KPiA+ID4gSW4gb3JkZXIg
dG8gY29udmVyZ2UgdGhlIGRpc2N1c3Npb24sIG1heWJlIHlvdSBjYW4gZXhwbGFpbiB3aGljaCBv
bmUNCj4gPiA+IG9mIHlvdXIgMyB1c2UgY2FzZXMgYW5kIHdoeSBjYW4ndCB3b3JrIHdpdGggX0Zf
TEVHQUNZX0hFQURFUiArDQo+IF9GX0xFR0FDWV9NQUMuDQo+ID4gSHlwZXJ2aXNvciBkb2VzIG5v
dCBpbnZvbHZlIGluIGZlYXR1cmUgbmVnb3RpYXRpb24gYW5kIGRldmljZSBsaWZlIGN5Y2xlIHBo
YXNlDQo+IHNvIGl0IGNhbm5vdCBuZWdvdGlhdGUgaXQuDQo+IA0KPiBXaXRoICBfRl9MRUdBQ1lf
SEVBREVSICsgX0ZfTEVHQUNZX01BQywgaHlwZXJ2aXNvciBkb2Vzbid0IG5lZWQgdG8gYmUNCj4g
aW52b2x2ZWQgaW4gdGhlIGZlYXR1cmUgbmVnb3RpYXRpb24gZm9yIG1vZGVybiBkZXZpY2VzIGFz
IHdlbGwuDQo+IA0KR3Vlc3QgZG9lcyBub3QgaGF2ZSB0aGlzIGZlYXR1cmUgbmVnb3RpYXRpb24g
ZHJpdmVyLg0KSHlwZXJ2aXNvciBpcyBub3QgaW52b2x2ZWQuDQpTbywgd2hvIG5lZ290aWF0ZXM/
DQo=

