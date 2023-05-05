Return-Path: <virtio-dev-return-12573-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7E3C77B75
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 12:50:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A98BC60348
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 12:50:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7B54B9866B9
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 12:50:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5FCE998653E; Fri,  5 May 2023 12:50:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 00E8598665C;
	Fri,  5 May 2023 12:48:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COEFJIzQw+qImCMA3EA3QtJMZtNUpiFkbfqfrWj/1MbsXaz+wap9HubjRs+NaHuwEE8owsFGL2dN1V4GCCVHq1iB8LEMmpxurn/P9Kr5PFkjgbaLluDpqXiSDivQA740NorDtoQRuWPmOemXHrINd3HUMY6MmhdxVXd9zoS2aiLcwKuViiXrGirvkLsNecB2aST7WOjgunP/rFt9WDLgw1g2QTStFW3OcJmSlHFH3Yzz/m3fG1qaiMtsLfCU4OFZwyqNCkKgEGSnegRM7OQ0UzQB0/f6DaHON+pVrrIAS+cJGFeNE6n/EXPEc7VGUpCTVfcZXbaLIZr/D2Mm++caLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFNZcO8SwMxqNXX4yTv+fwGcqy7wOFiuW80f5TYeln0=;
 b=SKpNiSnCpb2ij2KK6uJEdMpkIaei066FbS5U8vkt6FWzRYZw0N6TtPZZrM9l8th2BA1DbPeolFpa1wdGGtO/GsVYFI/fvYXBH7/5YgdZXybE3H8jFItb9F1BrdpTbo3U4GgNMkAmdkTF1vi/AT4qdzgE/Lgq2rm60wHD1Jcg8f5PaQ+9fuTgcikf/CiUHE5yVtP+jJMlOsH9ifQaNATX29lAd3Dx554zms+DBUyO1muSSw4Znpqoc60pis1l7PYb6vZ25b8OymyKdyiLzHkfQYbEMWVEQioigf6LDJUB4L3cvvFMGIsGPOnyvnQs5ab7YlHniA8uZVG8D/dirrSx5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>
CC: "sburla@marvell.com" <sburla@marvell.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>
Thread-Topic: [PATCH v1 1/2] transport-pci: Introduce legacy registers access
 commands
Thread-Index: AQHZfW80Yz+dzO+u+U23I2pKfq74J69LB/8AgACZ8ZA=
Date: Fri, 5 May 2023 12:48:52 +0000
Message-ID:
 <PH0PR12MB548178D2363F81D26062592BDC729@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230503032659.530330-1-parav@nvidia.com>
 <20230503032659.530330-2-parav@nvidia.com>
 <dba64a65-0538-a060-47a1-24d30f42ca49@redhat.com>
In-Reply-To: <dba64a65-0538-a060-47a1-24d30f42ca49@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB6000:EE_
x-ms-office365-filtering-correlation-id: 9b55b0c2-8adc-4931-699b-08db4d6714b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 st5mpiKOasWrExDARDleT9MJjDcLzrfcx14WJR1DqqAHsxqh5yKGfLWv91iJftFi5cNEGk14UETjsUQUPr840P/n35DWXv18rf7ghvkHXxmaNSd7216VK67b8LBswbQbGouodvezRd/fVz/8QZjjz0UIkuBMkyrIrgIjNoZBdDiDX765h3hUtAEmoW7fjjcgtmMlI6RE1GBnRZxNKE5bLOYXslM+H6clQPW5LnkddNuk5/0viaSEWCnap3WeYraHVf9piathuC012c/6TY9eQNTGl+4mxhb9Qkt6jpldFi4tmD0nJ+oDcD4us8gKqO6JJkfcqYLn5q8TvvfJF6PANALyxqseCqHBKhssGZiDyWtsAJas6+0QcIv033tVoO/QVHv+h4tANI06hyInYTXsEfDrwQFEzaeiKs7b37iAOLvBLZHCkurpT/AY3wPXNcAzB9oRHmDlFB8KSiP4t+hVpudH04RwBDeKUKeisnFXjmEzQ52VFp2LldANmKyVpogYIyUlVzjeuuC4cA98agYNdXiWoJHZ6z2BeX3TFfnCEo2Yiy2CbPP9e9QfHkPmredt4q1OippoaiZ7S7nL5jiC9rsxpSJE+N0xgREOBuJuE9K8SIdDfRk+QVfoJdMFPu9fiuDYQK2DDPYg/VCkScJPRyRqp/8b9JudafBa5N07td8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199021)(83380400001)(9686003)(316002)(8676002)(66946007)(966005)(110136005)(7696005)(4326008)(478600001)(5660300002)(186003)(76116006)(71200400001)(54906003)(6506007)(33656002)(38100700002)(52536014)(122000001)(8936002)(66476007)(64756008)(66446008)(38070700005)(66556008)(41300700001)(2906002)(55016003)(86362001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UDVvSWxCdWZBdzB6aGNCYWhwNDRLVm10Y0JoSDlvQmQxVVR0cEN4MnB3ZGNN?=
 =?utf-8?B?TThxTnl0R0dSR1NTZjV6LzhvVVNkMnV1dTg2dlNhOHZ2MGgycm9RZXlhL1VD?=
 =?utf-8?B?VzRRa3VFYk1ZeVdCU3Nqc0lHVGlhaGhMOTZ3ZDVQaWtXTGhjbW4ybUZreDg5?=
 =?utf-8?B?UFFzVEF4NGpYUTdmaTJaRnVUK1djVHNEK1ZlU25tZmZvUTNKOVlSUHo2aWlK?=
 =?utf-8?B?U1ArdnQ2cGpCZGtncHRjQlowcjBZWkMxS2crenBLYjVlZ3FwOGVhUWRpV0Rj?=
 =?utf-8?B?MTdiNTIvY2VDcE9aR0JZaDM0YVp6UFZCZEsrdXA4UEZJNDlPK1ZhR0Uzcjd0?=
 =?utf-8?B?bjg2eXZFRjR4Z0kvbTUxeDRwaTFEb054emJoY2JTRHE1S0ZQd0x0ME9aUzhy?=
 =?utf-8?B?V0VXTWdrZWh2SXNNaEtiWUJuNHFtTTQ3eEpKdm5mQlhiVVQzaHI0YytYSkh3?=
 =?utf-8?B?Qk1yRytXRTlxVWttaTAyalZINHhKZ3hXbjZJRlFGYjkzbDFML1REOXNvR291?=
 =?utf-8?B?VXl4TVQyY0cwTWVNWWVRc0RONWJRQXBwQ0trWXkrME5VdG13QkZmMjRJekFW?=
 =?utf-8?B?V0NqL3dXd0Z3MXRGTStYVzhkRndva0VhVlVkMHlJRVloZUZwTjlVYnJxMmpp?=
 =?utf-8?B?cFRreEMwTy9wdTNmK2wxSU5MUDd0bGUyYmRFbWx0a056WDYyalRhVGsvL0po?=
 =?utf-8?B?Ulo2dzNUeUpqRkRqenROQWF3Tm43NitQZC9CUXNTWjNKRHBPbm1iTDJMZzJT?=
 =?utf-8?B?K0pMUkNwMkFHYkhCRE5VNldLMDJ6aHl6UzEwRGxyT2hTTnJtYiswZzhpdFlh?=
 =?utf-8?B?R0tzbkc3cGJPR2M3dm9aanZNOGg0T3kvdkhvamlpWjlLb0ZmbDdORkkrUHp2?=
 =?utf-8?B?VXQrVGozTUN5SU1uamx5MkFmM2M5ZXVWZ1NNQ014bkMwZ3BjaUFOcTlDVVRE?=
 =?utf-8?B?K0p1bHZMeU5FR1ZQcGF4U3ZRKzgzeFpzbnNzYitRazRXU21QZUNiYVpvQlZr?=
 =?utf-8?B?U2xNYnF5YkRNeWlvODQrTDdycnZmNGp1VFF0ZXJKYXdRUDBFWXptS3k2MlFR?=
 =?utf-8?B?a3g5R1NtTjJVb3JVczU2RUJkdUlRYTZ2aVAvRkdCWC9VZDJZZ2gyUHk5Yktp?=
 =?utf-8?B?VmxHQlZGRDA1b1ZKUVh0eXJOcFowV0lDT0Z6cm9tLzJoM3ZqdVB3SVhrVXZN?=
 =?utf-8?B?Z2lpSHJFTDY2bjdqTWJqWHRKRUZEdi8zRUdMUmpvSUlRU0Z2U3NrbWsvWXFY?=
 =?utf-8?B?NHE5NEZINVl0SXhLUFFuZ3hkTStYMjUzUjRaTXQxdCtCdnV0OTYwbmRiRFBH?=
 =?utf-8?B?bCtkdVBEcGQ3TXNOd1N3ZXFMQmN0ekF5UFZQUW51RDlSK0Nxd2NzcU8vS0d6?=
 =?utf-8?B?WlpMNEVwZyt3YW1oUEZGTDRrU2h1Z2M3ZEZqRWR4Y3FZNWMrcXp6YUt4MG00?=
 =?utf-8?B?Y254aUZkK1dINHBsREsrM2ZuNGhvUVZxMEhIWVN1YUxlTHFMTE40WnBTdWpm?=
 =?utf-8?B?YmdJREUyLzNoR2NhTE5RS2g4eXRWazFqZEQ0VTdLblJNTmdIWWx1alJrc1Qw?=
 =?utf-8?B?TmhTL2syU0tQUnl1YnB5YjFNdDdwYkdSSGIyQVd0WmthSVJHTE5Xd2VRTjMx?=
 =?utf-8?B?SmlvU1IwOWZFUmJzUUxTTXBxa1FTa0ZJc2Z2ckttWVZkeTMwY2lTNkNBcHRs?=
 =?utf-8?B?MmhsSGNUSGhydHpxT0ZaQWdXdG05bi9hVHgwRGdEVHh4RzFJS29SSWJ0L043?=
 =?utf-8?B?TFhsdUtaTWtKRHRWMmFYZGUyRUwvZGtETDBDSVREaUhweTNDODBOY0ZxRTdq?=
 =?utf-8?B?QUptZ2JtU3IyYUlWYmdLVGhWdnluanczN2lsdHM3OGwrL0pTekRRYjNyZ3ZI?=
 =?utf-8?B?YWNCYWZlZkI4aHNJV2c4d00xdTUxa0ptZ0txaUN6cXJJNjBkMjNvQ01IM3Rj?=
 =?utf-8?B?S1RwMDB3NFJ1c29SL29ITTdBdWlXVUVCVnRldkRKbWkzWiszUVNjbEg0QW1L?=
 =?utf-8?B?dlVlcDBYV1RhZnVza1UvWU51U2dldHV1NmxzUVJDWXlBMWlxT2xOeHFsazVW?=
 =?utf-8?B?eG5XSE9OZkJWVkptZ2RFSzJWak54WlM2K0JQNjJ4VVdpdklmM2xuU2hRRVpj?=
 =?utf-8?Q?2Qoc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b55b0c2-8adc-4931-699b-08db4d6714b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 12:48:52.6721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +3eeApHshx9XwK3DLXF2agjr9bInm51Rot3IQSAvo4qHdMb5ViquBN/g3k8M5pAV2iuBHKcDF4d+L+pMdoMLVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6000
Subject: [virtio-dev] RE: [PATCH v1 1/2] transport-pci: Introduce legacy registers access
 commands

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIE1heSA0LCAyMDIzIDExOjI3IFBNDQo+IA0KPiBTbyB0aGUgInNpbmdsZSBzdGFjayIg
aXMga2luZCBvZiBtaXNsZWFkaW5nLCB5b3UgbmVlZCBhIGRlZGljYXRlZCB2aXJ0aW8NCj4gbWVk
aWF0aW9uIGxheWVyIHdoaWNoIGhhcyBkaWZmZXJlbnQgY29kZSBwYXRoIHRoYW4gYSBzaW1wbGVy
IHZmaW8tcGNpIHdoaWNoIGlzDQo+IGNvbXBsZXRlbHkgZHVwbGljYXRlZCB3aXRoIHZEUEEgc3Vi
c3lzdGVtLiANCkh1aC4gTm8uIGl0IGlzIG5vdCBkdXBsaWNhdGVkLiANClZmaW8tcGNpIHByb3Zp
ZGVzIHRoZSBmcmFtZXdvcmsgZm9yIGV4dGVuc2lvbiB0aGFuIGRvaW5nIHNpbXBsZSB2ZmlvLXBj
aSBmb3IgZXh0ZW5zaW9ucy4NCkkgYW0gbm90IGRlYmF0aW5nIGhlcmUgdmRwYSB2cyBub24gdmRw
YSB5ZXQgYWdhaW4uDQoNCj4gQW5kIHlvdSBsb3NlIGFsbCB0aGUgYWR2YW50YWdlcyBvZg0KPiB2
RFBBIGluIHRoaXMgd2F5LiBUaGUgZGV2aWNlIHNob3VsZCBub3QgYmUgZGVzaWduZWQgZm9yIGEg
c2luZ2xlIHR5cGUgb2YNCj4gc29mdHdhcmUgc3RhY2sgLCBpdCBuZWVkIHRvIGxlYXZlIHRoZSBk
ZWNpc2lvbiB0byB0aGUgaHlwZXJ2aXNvci9jbG91ZCB2ZW5kb3JzLg0KPg0KSXQgaXMgbGVmdCB0
byB0aGUgaHlwZXJ2aXNvci9jbG91ZCB1c2VyIHRvIGRlY2lkZSB0byB1c2UgdmRwYSBvciB2Zmlv
IG9yIHNvbWV0aGluZyBlbHNlLg0KIA0KPiANCj4gPiAgICAgdmlydGlvIGRldmljZSB0eXBlIChu
ZXQvYmxrKSBhbmQgYmUgZnV0dXJlIGNvbXBhdGlibGUgd2l0aCBhDQo+ID4gICAgIHNpbmdsZSB2
ZmlvIHN0YWNrIHVzaW5nIFNSLUlPViBvciBvdGhlciBzY2FsYWJsZSBkZXZpY2UNCj4gPiAgICAg
dmlydHVhbGl6YXRpb24gdGVjaG5vbG9neSB0byBtYXAgUENJIGRldmljZXMgdG8gdGhlIGd1ZXN0
IFZNLg0KPiA+ICAgICAoYXMgdHJhbnNpdGlvbmFsIG9yIG90aGVyd2lzZSkNCj4gPg0KPiA+IE1v
dGl2YXRpb24vQmFja2dyb3VuZDoNCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gVGhl
IGV4aXN0aW5nIHZpcnRpbyB0cmFuc2l0aW9uYWwgUENJIGRldmljZSBpcyBtaXNzaW5nIHN1cHBv
cnQgZm9yIFBDSQ0KPiA+IFNSLUlPViBiYXNlZCBkZXZpY2VzLiBDdXJyZW50bHkgaXQgZG9lcyBu
b3Qgd29yayBiZXlvbmQgUENJIFBGLCBvciBhcw0KPiA+IHNvZnR3YXJlIGVtdWxhdGVkIGRldmlj
ZSBpbiByZWFsaXR5LiBDdXJyZW50bHkgaXQgaGFzIGJlbG93IGNpdGVkDQo+ID4gc3lzdGVtIGxl
dmVsIGxpbWl0YXRpb25zOg0KPiA+DQo+ID4gW2FdIFBDSWUgc3BlYyBjaXRhdGlvbjoNCj4gPiBW
RnMgZG8gbm90IHN1cHBvcnQgSS9PIFNwYWNlIGFuZCB0aHVzIFZGIEJBUnMgc2hhbGwgbm90IGlu
ZGljYXRlIEkvTyBTcGFjZS4NCj4gPg0KPiA+IFtiXSBjcHUgYXJjaCBjaXRpYXRpb246DQo+ID4g
SW50ZWwgNjQgYW5kIElBLTMyIEFyY2hpdGVjdHVyZXMgU29mdHdhcmUgRGV2ZWxvcGVy4oCZcyBN
YW51YWw6DQo+ID4gVGhlIHByb2Nlc3NvcuKAmXMgSS9PIGFkZHJlc3Mgc3BhY2UgaXMgc2VwYXJh
dGUgYW5kIGRpc3RpbmN0IGZyb20gdGhlDQo+ID4gcGh5c2ljYWwtbWVtb3J5IGFkZHJlc3Mgc3Bh
Y2UuIFRoZSBJL08gYWRkcmVzcyBzcGFjZSBjb25zaXN0cyBvZiA2NEsNCj4gPiBpbmRpdmlkdWFs
bHkgYWRkcmVzc2FibGUgOC1iaXQgSS9PIHBvcnRzLCBudW1iZXJlZCAwIHRocm91Z2ggRkZGRkgu
DQo+ID4NCj4gPiBbY10gUENJZSBzcGVjIGNpdGF0aW9uOg0KPiA+IElmIGEgYnJpZGdlIGltcGxl
bWVudHMgYW4gSS9PIGFkZHJlc3MgcmFuZ2UsLi4uSS9PIGFkZHJlc3MgcmFuZ2Ugd2lsbA0KPiA+
IGJlIGFsaWduZWQgdG8gYSA0IEtCIGJvdW5kYXJ5Lg0KPiA+DQo+ID4gQWJvdmUgdXNlY2FzZSBy
ZXF1aXJlbWVudHMgY2FuIGJlIHNvbHZlZCBieSBQQ0kgUEYgZ3JvdXAgb3duZXINCj4gPiBlbmFi
bGluZyB0aGUgYWNjZXNzIHRvIGl0cyBncm91cCBtZW1iZXIgUENJIFZGcyBsZWdhY3kgcmVnaXN0
ZXJzIHVzaW5nDQo+ID4gYW4gYWRtaW4gdmlydHF1ZXVlIG9mIHRoZSBncm91cCBvd25lciBQQ0kg
UEYuDQo+ID4NCj4gPiBTb2Z0d2FyZSB1c2FnZSBleGFtcGxlOg0KPiA+IC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQo+ID4gVGhlIG1vc3QgY29tbW9uIHdheSB0byB1c2UgYW5kIG1hcCB0byB0aGUg
Z3Vlc3QgVk0gaXMgYnkgdXNpbmcgdmZpbw0KPiA+IGRyaXZlciBmcmFtZXdvcmsgaW4gTGludXgg
a2VybmVsLg0KPiA+DQo+ID4gICAgICAgICAgICAgICAgICArLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LSsNCj4gPiAgICAgICAgICAgICAgICAgIHxwY2lfZGV2X2lkID0gMHgxMDBYICAgfA0KPiA+ICst
LS0tLS0tLS0tLS0tLS18cGNpX3Jldl9pZCA9IDB4MCAgICAgIHwtLS0tLSsNCj4gPiB8dmZpbyBk
ZXZpY2UgICAgfEJBUjAgPSBJL08gcmVnaW9uICAgICB8ICAgICB8DQo+ID4gfCAgICAgICAgICAg
ICAgIHxPdGhlciBhdHRyaWJ1dGVzICAgICAgfCAgICAgfA0KPiA+IHwgICAgICAgICAgICAgICAr
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsgICAgIHwNCj4gPiB8ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4gKyAgICstLS0tLS0tLS0tLS0tLSsgICAgICst
LS0tLS0tLS0tLS0tLS0tLSsgfA0KPiA+IHwgICB8SS9PIEJBUiB0byBBUSB8ICAgICB8IE90aGVy
IHZmaW8gICAgICB8IHwNCj4gPiB8ICAgfHJkL3dyIG1hcHBlciAgfCAgICAgfCBmdW5jdGlvbmFs
aXRpZXMgfCB8DQo+ID4gfCAgICstLS0tLS0tLS0tLS0tLSsgICAgICstLS0tLS0tLS0tLS0tLS0t
LSsgfA0KPiA+IHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwN
Cj4gPiArLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0rDQo+ID4g
ICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gDQo+IA0KPiBTbyB0aGUgbWFw
cGVyIGhlcmUgaXMgYWN0dWFsbHkgdGhlIGNvbnRyb2wgcGF0aCBtZWRpYXRpb24gbGF5ZXIgd2hp
Y2gNCj4gZHVwbGljYXRlcyB3aXRoIHZEUEEuDQo+IA0KWWV0IGFnYWluIG5vLiBJdCBpbXBsZW1l
bnRzIFBDSSBsZXZlbCBhYnN0cmFjdGlvbi4NCkl0IGlzIG5vdCB0b3VjaGluZyB0aGUgd2hvbGUg
UUVNVSBsYXllciBhbmQgbm90IGF0IGFsbCBnZXR0aW5nIGludm9sdmVkIGluIHZpcnRpbyBkZXZp
Y2UgZmxvdyBvZiB1bmRlcnN0YW5kaW5nIGRldmljZSByZXNldCwgYW5kIGRldmljZSBjb25maWcg
c3BhY2UsIGN2cSwgZmVhdHVyZXMgYml0cyBhbmQgbW9yZS4NCkFsbCBvZiB0aGVzZSB3ZXJlIGRp
c2N1c3NlZCBpbiB2MCwgbGV0cyBub3QgcmVwZWF0Lg0KDQo+IA0KPiA+ICAgICstLS0tKy0tLS0t
LS0tLS0tLSsgICAgICAgKy0tLS0rLS0tLS0tLS0tLS0tKw0KPiA+ICAgIHwgKy0tLS0tKyAgICAg
ICAgIHwgICAgICAgfCBQQ0kgVkYgZGV2aWNlIEEgfA0KPiA+ICAgIHwgfCBBUSAgfC0tLS0tLS0t
LS0tLS0rLS0tLT4rLS0tLS0tLS0tLS0tLSsgfA0KPiA+ICAgIHwgKy0tLS0tKyAgICAgICAgIHwg
ICB8ICAgfCB8IGxlZ2FjeSByZWdzIHwgfA0KPiA+ICAgIHwgUENJIFBGIGRldmljZSAgIHwgICB8
ICAgfCArLS0tLS0tLS0tLS0tLSsgfA0KPiA+ICAgICstLS0tLS0tLS0tLS0tLS0tLSsgICB8ICAg
Ky0tLS0tLS0tLS0tLS0tLS0tKw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgICArLS0tLSstLS0tLS0tLS0tLS0rDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICB8IFBDSSBWRiBkZXZpY2UgTiB8DQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICstLS0tPistLS0tLS0tLS0tLS0tKyB8DQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8IHwgbGVnYWN5IHJlZ3MgfCB8DQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICstLS0tLS0tLS0tLS0tKyB8DQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICArLS0tLS0tLS0tLS0tLS0tLS0rDQo+ID4NCj4gPiAyLiBWaXJ0aW8gcGNp
IGRyaXZlciB0byBiaW5kIHRvIHRoZSBsaXN0ZWQgZGV2aWNlIGlkIGFuZA0KPiA+ICAgICB1c2Ug
aXQgYXMgbmF0aXZlIGRldmljZSBpbiB0aGUgaG9zdC4NCj4gDQo+IA0KPiBIb3cgdGhpcyBjYW4g
YmUgZG9uZSBub3c/DQo+IA0KQ3VycmVudGx5IGEgUENJIFZGIGJpbmRzIHRvIHRoZSB2aXJ0aW8g
ZHJpdmVyIGFuZCB3aXRob3V0IGFueSB2ZHBhIGxheWVyaW5nLCB2aXJ0aW8gbmV0L2JsayBldGMg
ZGV2aWNlcyBhcmUgY3JlYXRlZCBvbiB0b3Agb2YgdmlydGlvIFBDSSBWRiBkZXZpY2UuDQpOb3Qg
c3VyZSBJIHVuZGVyc3Rvb2QgeW91ciBxdWVzdGlvbi4NCg0KPiA+ICtcYmVnaW57bHN0bGlzdGlu
Z30NCj4gPiArc3RydWN0IHZpcnRpb19hZG1pbl9jbWRfbHJlZ193cl9kYXRhIHsNCj4gPiArCXU4
IG9mZnNldDsgLyogU3RhcnRpbmcgYnl0ZSBvZmZzZXQgb2YgdGhlIHJlZ2lzdGVyKHMpIHRvIHdy
aXRlICovDQo+ID4gKwl1OCBzaXplOyAvKiBOdW1iZXIgb2YgYnl0ZXMgdG8gd3JpdGUgaW50byB0
aGUgcmVnaXN0ZXIuICovDQo+ID4gKwl1OCByZWdpc3RlcltdOw0KPiA+ICt9Ow0KPiA+ICtcZW5k
e2xzdGxpc3Rpbmd9DQo+IA0KPiANCj4gU28gdGhpcyBhY3R1YWxseSBpbXBsZW1lbnRzIGEgdHJh
bnNwb3J0LCBJIHdvbmRlciBpZiBpdCB3b3VsZCBiZSBiZXR0ZXINCj4gKGFuZCBzaW1wbGVyKSB0
byBkbyBpdCBvbiB0b3Agb2YgdGhlIHRyYW5zcG9ydCB2cSBwcm9wb3NhbDoNCj4gDQo+IGh0dHBz
Oi8vbGlzdHMub2FzaXMtb3Blbi5vcmcvYXJjaGl2ZXMvdmlydGlvLWNvbW1lbnQvMjAyMjA4L21z
ZzAwMDAzLmh0bWwNCj4gDQpJIGFsc28gd29uZGVyIHdoeSBUVlEgY2Fubm90IHVzZSBBUS4NCg0K
PiBUaGVuIGl0IGFsaWducyB3aXRoIFNJT1YgbmF0aXZlbHkuDQo+DQpTSU9WIGlzIG5vdCB3ZWxs
IGRlZmluZWQgc3BlYywgd2hlbmV2ZXIgaXQgaXMgZGVmaW5lZCwgaXQgY2FuIHVzZSBBUSBvciBU
VlEuDQoNCldlIGFsc28gZGlzY3Vzc2VkIHRoYXQgbWVkaWF0aW9uIG9mIGh5cGVydmlzb3IgZm9y
IGNvbnRyb2wgcGF0aCBpbiBzb21lIHVzZSBjYXNlIGlzIG5vdCBkZXNpcmVkLCBoZW5jZSBJIHdp
bGwgbGVhdmUgdGhhdCBkaXNjdXNzaW9uIHRvIHRoZSBmdXR1cmUgd2hlbiBTSU9WIGFycml2ZXMu
DQo=

