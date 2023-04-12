Return-Path: <virtio-dev-return-12177-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A446C77B6E
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:01:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C01352A829
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:01:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BACAC9865FA
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:01:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B08AA98651C; Wed, 12 Apr 2023 05:01:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9DFDF986509;
	Wed, 12 Apr 2023 05:01:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpuzFYQB5CdmGMbWVKT2KfVorp1duCPy7LhrfFDquvuv3RYtb5Rk+QXmZ1yNOCZ1ah17hwiRZLBJesviEZqXzmQERFzdGFn1fDWrS0M2nSAjq0HmGI9MRMndmEjMDoBj5PUBoCMlC5pmpZNoy6zr2uYrgReU5howO4NT9iZEKGFmfF0SpSFChxqEt8QVTTT0KAemOmr0r+n51AJ4ZpN/rWyRTjRyyI7I1UvC5Y679Qaq3fuMnvVF4VdzrQnMY+Ppdry1YEBITENtOcpQr1NgftMz0AOROAEv1GH6IfLSjM0FWh4UV1r3fCNbrRygC0XFWYe+QoxOztvshGA4SgrN7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8zQLB8zSyZW5IXcLyrS2lqFoWW59hte19hzTlUVyj8=;
 b=YMUjv5PLf02yutqXfCy049tuheXcDrhELkKrtebNZv4dDA1xAaxoU+0bbGwAAXYSHL1d9Yk64/sOCp+u3rwhPyLcsuudWhDlFXjuhob6OTY6hoaAQ8B3qdU/EZJegyYB1DEXlxhWEPwdQzNaO52/9CHu5FnMFAF2V1UBMCUUUSlsO9U288CoY+szy4gqMb2MKkCgLmi5L+4UBtQx/LI3blVPPfnrSx/AWbjfr2uxXwMD76iT3sY8U7m4na2ZDW//iodW+Nvy7gfd2E2hdH2Ld0Rc9jwF5xE5NacLofwd/jAqTDaYgv0cPzrxMysgDclE9oRUBL570H0fG4EUsF9Ikg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>, Yan Vugenfirer <yan@daynix.com>
Thread-Topic: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers
Thread-Index:
 AQHZY1tLAUtRpuZtUUOucQPGJlFfkK8flpUAgAQ7nwCAAE6hgIAAAXwAgAAFegCAAAt0AIAALl6AgAEOIwCAAFEgAIAAIPWAgAAcJ4CAASFtgIAABJ4AgAAKJYCAAACFsA==
Date: Wed, 12 Apr 2023 05:01:23 +0000
Message-ID:
 <PH0PR12MB548118F57BB4B4A4F8DC9D7ADC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230410020906-mutt-send-email-mst@kernel.org>
 <CACGkMEtiROwuB+ECJqd13qdpMJSTMoDOzi1u_i85==42C0XSXw@mail.gmail.com>
 <20230410023715-mutt-send-email-mst@kernel.org>
 <CACGkMEs+E_OarQxP3NmLk3iSi7U0WgAn-m3b4eX7ULu1+v=sOw@mail.gmail.com>
 <20230410060417-mutt-send-email-mst@kernel.org>
 <CACGkMEuc47PdmQdC67Nz4AvX_+jy+XBgCkwZ1BHmM8VGb9gywA@mail.gmail.com>
 <20230411030056-mutt-send-email-mst@kernel.org>
 <CACGkMEt2QAfhCgpYjSRNzf3n4W_HJLrMfE9JHzocR_gPH_Zrtg@mail.gmail.com>
 <20230411063945-mutt-send-email-mst@kernel.org>
 <CACGkMEufWUXHKahg3GLOKfV5aptbiek_DKwy+7rCfMya2GPaTQ@mail.gmail.com>
 <20230412000802-mutt-send-email-mst@kernel.org>
 <CACGkMEshNydwBD=Q0JW-SDY6xyiJ4uVrLn+pxbUrinycBKwsrw@mail.gmail.com>
In-Reply-To:
 <CACGkMEshNydwBD=Q0JW-SDY6xyiJ4uVrLn+pxbUrinycBKwsrw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM8PR12MB5398:EE_
x-ms-office365-filtering-correlation-id: 3884a1c8-8d79-49c8-9470-08db3b12f6dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YALWwyRVT8VAju1LJlza9Iytfsw8N/Lp7daO0q26CN9W4mSUZEUk1qgphbdA8ZB7HtbB9FsrV2R5ChsnliiwL5Sjnv9QHL7BCmTZ0W/9R6qkaigt7EEfAPIzzpstq2kNRQPDHS1Tm7MVGIMmPER9g19cznTG0jl6YdSwEyEs0jy47UJ+y2eeegBKnHPLXjRAkwMUW7rq5CVq1/DUaScSt5fsJo0DAhaaZA56bBMdQhYcN7PmvPddfYzSRFqN1Z16+NQByhrrIiyqw6f00pUeYtjVdobx/7sSykn4hEonwSdK1aMSS9OBSKHDxdJ6oTKPp+iIfutuK45NOMi69Nh8u/URVVTNTGiCtFJTcED6NcjcFO4tbh+EQ6OMTqE4pU8pyPuv03z6s58PesKbr4FHH7/sYLf0WgZ4n3Phrav1KQ15KCgvvGmSchmPV6lUmxTbjU/GPAHUl8Ac/+9qPN/wuic+rqsQpBSwjPmKZ6M7D/rN7TfKryoCBC1HKHNsEhxgUK/frmyRZHV+29k0GizU78edrVfDAl1C+1sv/CGXIvy3lVOHnzClOqaYzvx62xSu0kG79Apkixa/kPIpp0/kDa190Z/dZ//TVxQcMgXZ3uHNKYaCdPQgsb3C6+hXt3Mp
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199021)(4326008)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007)(8676002)(2906002)(41300700001)(52536014)(8936002)(316002)(5660300002)(478600001)(110136005)(54906003)(83380400001)(71200400001)(7696005)(9686003)(55016003)(6506007)(33656002)(186003)(38100700002)(38070700005)(86362001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WFZ5NDVyaWlnaU5WR3pTcjNsMFo0MzhZeit2OHRuUFJ5S01zSlh0STdMY1B1?=
 =?utf-8?B?enhsaUlaUkVlOGlIYkVFZ0JBU2xSTEYyZzVZbFFlZlFwZEZhZUZPbHc3My9H?=
 =?utf-8?B?aGU1bDBZazg0Ym5IM2N2djEvY1c1NzY1cklIeHJ2ZFREYlFRU3ZLQ1QzZngr?=
 =?utf-8?B?TC80M1BhSG1KTm45eTljTWszY0hiOXk1NFpCVitGNnBySHBVTGMxanNnTUZM?=
 =?utf-8?B?S1Y0ZnJHeStYaHJobjlLbjlZaGprVkN5bDlmVVczT3YzWTZzNjAwQmM5Q3BS?=
 =?utf-8?B?ZnZDODI1bEFUb1FkWmw5SDNaOW9XYzBPRFVsZ1djOUNWUEVxVXJGTVAzWTRE?=
 =?utf-8?B?bElmYWNvVDg3QmZXRXJqdlV6Z2ZvSnFmY2FOT1hsUFEydEFaRjFpdkRwcW85?=
 =?utf-8?B?bkZEWVJvaXc2SXd5N3Ywd0xQd2lCWFIzUHBCNUpWWUFLQzUvK2tpTXhyS3Zk?=
 =?utf-8?B?dThLazIzNy9ncGNTY053TjZBMVUvVlZCb0I2U2Y0RURHdUFvTTg5QXg4NGV6?=
 =?utf-8?B?NFlURzlGWjRhWjZRemNtL1R6b2w5RnlmVEdJc2pLYjU2aWgyVW9SdU9zSFFz?=
 =?utf-8?B?VXhMRnJjMVB4SndNVXVISDRCSTdLdGFJRXN1MC9VeURmZ2ZhVThMaFlJcHdR?=
 =?utf-8?B?T3Nhb1hwV3dDYnFZV1lEb0VIRjhDbGwwL2tTd0U3ZXNnMUVzdjZmMzlxNWhp?=
 =?utf-8?B?UGhMOVpoV2pCNmIrSzQxeDVmS2pFZHhEdTFUSTJhL1llSWQ2NnJubVBXekZR?=
 =?utf-8?B?T2s1OHhxdUVpMlpPOCt4QWVuNkRaQUtNdEdzcTNuZjd5em5nbXl4WWFuSUJm?=
 =?utf-8?B?WTNKdWJSM3FTQXVYMmhYOXR3SS9LYUkzZnR0dnVmdjBpNGc2RDNzcFVGZFRt?=
 =?utf-8?B?KzFBbW52QmN5UitEWWNmd0RjNHhQQUduYU5tUDlLenM4cXJKeDBLNHVvcU1s?=
 =?utf-8?B?eWdiOW9PMTk1WW1vYmM4RzAzaFRTbzdkUkZVaWxhWW5FZFRGTGU0amhIWVFH?=
 =?utf-8?B?VFZEZjVEd2Z6eGdPQm5hNHJCUVRvbXZ4T2xPQnRNdVErL3cxRnkwa0lrYlNj?=
 =?utf-8?B?cXVXVGVaM3RXK3RsaDE5aENSS0sza2V6OFFtMlk2dnZicVZuTVYyRHBHOUZk?=
 =?utf-8?B?YVkydmI5RmpIMkhnUlVYSEI2cDIvRGFyREYxazB2Z0x6OEYxWWNvTVRRUVFh?=
 =?utf-8?B?SkVpRjZrSG8wR1F6QU00cDA5VnRlT29oT3BRY1NHb1piYTJkRTVDL0VJMmoz?=
 =?utf-8?B?LzU3K0licG5UVDlnZTFxZGtLNWVHdnlJTkczYWJ4bUZKZVN5cG1tK3F4R2ds?=
 =?utf-8?B?bFJrYzlKVjlaRzBiNnNESU5LY1ZQNnpISUNidjRHNWw4aTNKSDEwWFN2NE9y?=
 =?utf-8?B?Y1NjaUU3SnJiRHNVSUZ4bG51Ull3dHd0Z1F4RHgwbUZsZ1RXekhYWnhaYVNo?=
 =?utf-8?B?QW5zckJPaEp2VDR1VE5VbDJibUw4U0IrU29ZczQ4dmZ3MWxrTmxVTk5uU0c0?=
 =?utf-8?B?QnpJNmhyMEhqMHBoTDQvZHREQ0NySmxvVGMxb1BQcGxuR1VBVlhPNTM5MTF2?=
 =?utf-8?B?VE9ZZ3pPYkJBZlp4b3VnRjZrNzZTa09vaEdYS1g1ZlJXQSttbVR5WjJkeHdO?=
 =?utf-8?B?OGtsNkIvMGpGUGo0WXZGMGRGWFZzUExhVi9PUUZXdGpidFJNUndWbitWWkt0?=
 =?utf-8?B?Z0VuY2pFa0RuY2tUaERBakhaTWlYTVlpam5MdDYxQTA4MFpOYlVUTkkyOTAz?=
 =?utf-8?B?cGUxRzFRd05SelpwdnA2dFFNbUhKS3lqKzlOSFdFS29pV1JiL2FmMHdYTFRu?=
 =?utf-8?B?TTRRZjFOYllRbDJFLzNmWHNmYkZuRXJUc1VSamNqd1Vhb3JkNlU4ZU4xVU9t?=
 =?utf-8?B?cHBXOWhEL2Y5SmkxYjNSUVBpZ1BwZW8zd3QzVzJBbXhpY3hIaVN5NnpTd3NV?=
 =?utf-8?B?bG1rTVp4OWFBQnVpOGFna2ZiZHhlOU93WVFSM2hnVjV4aWRNcUQyaldtWjRr?=
 =?utf-8?B?VFhqOVY0ekFCM082eEpJckJJYW5hbVVVZnJrVlZIanJ5eFdCcDlheTVYSnov?=
 =?utf-8?B?QTBGdDVyc0hwVllxSUNSWE9iQnYyemRaYXk3STV2dC9XWTc3eXg2T3AwRCtH?=
 =?utf-8?B?SzZodGRJbjVpcEpGYWVUQ2I1bnVkQUY1VVVLc2VCU3QxYnBXemYrdmJacFQ2?=
 =?utf-8?Q?Uzu6CSZnqIdZh3EFTVJgxpI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3884a1c8-8d79-49c8-9470-08db3b12f6dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 05:01:23.9960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hTertjyDwd1hzpj/RhXh2ZGCxsXgvWblt6UbEcgS7+8I2GNKCa3IhjTc3HQHZBTErHPOdrX90wL/6jOgoi0q/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5398
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogV2Vk
bmVzZGF5LCBBcHJpbCAxMiwgMjAyMyAxMjo1MSBBTQ0KPiANCj4gWWVzLCBidXQgdGhpcyBwcm9w
b3NhbCB3aWxsIGRyYWcgdXMgYmFjayB0byBsZWdhY3ksIGlzbid0IGl0PyANCk5vLiBUaGlzIHBy
b3Bvc2FsIHN1cHBvcnRzIHRoZSBsZWdhY3kgdHJhbnNpdGlvbmFsIHBjaSBkZXZpY2UuDQoNCj4g
T3IgaWYgaXQgaXMgdXNlZCBvbmx5IGluDQo+IHRoZSB2aXRhbGl6YXRpb24gZW52aXJvbm1lbnQs
IHdoYXQncyB0aGUgYWR2YW50YWdlcyBvZiBkb2luZyBpdCBvdmVyIHNpbXBseQ0KPiBtZWRpYXRp
bmcgb24gdG9wIG9mIG1vZGVybiBkZXZpY2U/DQo+IA0KQmVjYXVzZSB0aGUgc3BlYyBmb3IgbW9k
ZXJuIGRldmljZSBkbyBub3QgYWxsb3cgaXQuIERpc2N1c3NlZCBpbiB0aGVzZSB0aHJlYWRzLg0K
DQo+IDEpIGxlZ2FjeSBNTUlPIGJhcjogc3BlYyBjaGFuZ2VzLCBoeXBlcnZpc29yIG1lZGlhdGlv
bg0KPiAyKSBtb2Rlcm4gZGV2aWNlOiBubyBzcGVjIGNoYW5nZXMsIGh5cGVydmlzb3IgbWVkaWF0
aW9uDQo+DQpUaGlzIHF1ZXN0aW9uIHJlcGVhdHMgdGhlIHNhbWUgZGlzY3Vzc2lvbiBvY2N1cnJl
ZCBpbiB0aGlzIHBhdGNoIHNlcmllcy4NCllvdSBtaWdodCB3YW50IHRvIHJlZmVyIGl0IGFnYWlu
IHRvIGF2b2lkIHJlcGVhdGluZyBhbGwgb3ZlciBhZ2Fpbi4NCg0KPiAxKSBpdCdzIGJldHRlciBu
b3QgaW52ZW50IGFueSBvZiBuZXcgZmFjaWxpdGllcyBmb3IgbGVnYWN5DQo+IDIpIGlmIGxlZ2Fj
eSBpcyBpbnNpc3RlZCwgYWxsb3cgTU1JTyBCQVIwIGlzIG11Y2ggc2ltcGxlciBhbmQgYmV0dGVy
DQpZb3UgaGF2ZSBtaXNzZWQgZmV3IGVtYWlscy4gOikNCk1NSU8gQkFSIGlzIHByb3Bvc2VkIGhl
cmUgYW5kIGl0IGlzIG5vdCBsaW1pdGVkIHRvIEJBUiAwLg0KSXQgaXMgbGVmdCBmb3IgdGhlIGRl
dmljZSB0byBlaXRoZXIgbWFwIHNvbWV0aGluZyBpbiBleGlzdGluZyBCQVIgb3IgdXNlIEJBUiAw
Lg0KQmVjYXVzZSBQQ0kgaGFzIG9ubHkgMyBCQVJzLg0KQSBkZXZpY2UgbWF5IHdhbnQgdG8gc3Vw
cG9ydCBsZWdhY3kgYW5kIG5vbi1sZWdhY3kgZnVuY3Rpb25hbGl0eSBib3RoIGF0IHRoZSBzYW1l
IHRpbWUuDQpTbyBiZXR0ZXIgbm90IHRvIGhhcmQgd2lyZSBmb3IgQkFSIDAuDQo=

