Return-Path: <virtio-dev-return-12688-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE408C7EE23
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 15:26:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 10FA61318ED
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 15:26:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B132C9865ED
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 15:26:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 884D998670D; Mon, 15 May 2023 15:26:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3FA23986509;
	Mon, 15 May 2023 15:25:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwxfCDH4G0GLA3x7l76XXoj2B9fSlG5+FoEtWbZ9JTPad16pSdDN7R2hIy35IT2DeUNWG++PulzhuSQNCzKslOcwYrR/TQmwZA5H9xCM4EB7Ctjb1h+r10ytzZsCz+X2SMhGz7sG14DwO2OGLfGDGk80H4fKjS00aWb+SJ85xncua0woaw4aJ8rc/zuAYHDA1cxUVDPTolP9nqjQ5R1NypdXth0JDALUWAqhgWZJFJSHRHkpyD5ujlALYKHPXoq7SeO6WYuNuYtuwXpsH0lIiJx2+AZJMcREFStv4xBOUrIjk9TKJJ/6BueZyDFdd4I79JHRZIM0YAm7nh3NdlensA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ixlr1kkZHUAVn8AtefVPd/Xx9A/2MUcjX4o8M2L8uZk=;
 b=kE/vvTtNPJsH2M/kG2i3Cf9mFyGfJotFoHawjPm2zc0ARjvI6M31tRB46loKBAA5hxdZuJsYjdo8cuYtzT9yYY+MkLWd2atJjY65MaXnC1Fk7jawYXwxAYV1bQGlVbvCCLUrKHxDKiNQ/7z6oOo6Je33q7L6m7votORMfGiCs+Uada21/1pjpw+cCDw3tuG2FuLf9Bwxyaz5SE8JkuobI4NJ8GUF1Fs50Sag6unzMIur21DlSzLa8tys/6j4Y3nltQp7IMty0qqcKpOvnL/pV4P437CV9oG8yUYUGsBI8jrIShj6vuUuEDkwbm12is4NNhSshWJCahuECj4dPIC2RQ==
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
Thread-Topic: [virtio-comment] Re: [PATCH v2 0/2] transport-pci: Introduce
 legacy registers access using AQ
Thread-Index:
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIAA9w4AgACx3QCAAADx0IABk3UAgAAIcwCAAMU1AIAA/xAAgAbQOEA=
Date: Mon, 15 May 2023 15:25:37 +0000
Message-ID:
 <PH0PR12MB548106E74CD8B6B3FE13FBD9DC789@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230506000135.628899-1-parav@nvidia.com>
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <b33fe999-8491-30b4-5021-589a2fe87398@nvidia.com>
 <CACGkMEsSJVG8mzuo3BH1xQzz5TyNbO+o3GcYwoXchcYVOczTTg@mail.gmail.com>
 <PH0PR12MB5481AC52CCAE9636E17C7565DC769@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu1oU0wzygicS0bApoWuRaWkWsPivKRiq-ghezB=hg+Fw@mail.gmail.com>
 <CACGkMEuqGtJP3vXoHrXOBgvPz3woo900+U9kYX1xZnM5h_qXWg@mail.gmail.com>
 <03c8f7ca-8235-a5a7-5367-b6fd59ad0447@nvidia.com>
 <CACGkMEv3XBXB_i_PUwxgvY8_UWipGVu8xuGQATp+kHOx3Vdnsg@mail.gmail.com>
In-Reply-To:
 <CACGkMEv3XBXB_i_PUwxgvY8_UWipGVu8xuGQATp+kHOx3Vdnsg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN0PR12MB5956:EE_
x-ms-office365-filtering-correlation-id: 0bf0bee0-e761-42a2-99b5-08db5558a281
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9lWVWQ+Dbn39v/zqUCbQemyFSF7GJoEg4YLudHsSV/VptdAvQCtMVqpiYdfSAxawzYp0aPHT9wCBa/KS+DppnllkdkpAwX7OCdig6cprpzG5NU9iFgtCyFzB8uHmPV+pF5XkgX8Vmxn5x+HTYNTJJZozt+hNTltp9AjXI9/smNdX6tiTvezWW1mMB3yT7j/VaChrdgnDVO851ODFyN0+2SMH2w0rW7L8AmFUUsb1W219rGaFbLFWgCdIwX+wJ0H5l0G1WAlBONes1/uXmFzxcg61DFyQBs9F+Fip1obDoZEuodGnTxYfdy9he9OJJMv3gHqlVghWCklBg2swiwcZhBNKw6IhrbVpb4Mv4r8WlZny4HRdY6kFf4rNVvhkWcAzp5xw2Y9K8eUi1E/O7x90LEouR4A4SqtVMoxIcVbSx8eAZMINaxZQfMJe+PGhQqDqoWe52sFpZ66qkZTLQ0oQc4hGti+kKIu1cnjyXGkIFhXYKHYz+3Q3UOc1ZjBKb5dZLqmxTCcHQNa12/x8wFxv7pbLDMPC05HbpVA1tCFFpUCaaHydRPvVKLJ959d8NwER51EBaE1qveFznQqHggQYxuk0zwo/5WVfOZvXl5CXudFHJ50McwfAANxdAN+ra6sR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199021)(55016003)(4326008)(2906002)(107886003)(83380400001)(76116006)(66476007)(66446008)(64756008)(66946007)(66556008)(478600001)(7696005)(54906003)(8936002)(8676002)(9686003)(52536014)(186003)(53546011)(6506007)(5660300002)(41300700001)(6916009)(71200400001)(316002)(38070700005)(38100700002)(86362001)(122000001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bThPRklSeWdkZHBvbFZRdkoxSXlWUXAzeDNOSHB1RW5GQWV3c2k2UmNoUjFw?=
 =?utf-8?B?emlvanJ0ZnVDVUhhU0Q5dE1KNW5EeG4zYXBWUWpzSHJVMGE2U00ya3lIRUI4?=
 =?utf-8?B?TzJqdTZ3cTJaVVpyZitNQlRhVFc1aFFGeTdtdE1sdGFkOThXSFF4UzdReHk4?=
 =?utf-8?B?b2Jtb3Q4UElyblpmZ0pPc005djRMckNpanJvVVVybmxNbGJZbHZQSUVDV09D?=
 =?utf-8?B?bVQxeWM2enpVc0Rid0NuVjZTRThkc1IzSXRUOXp2d01wZm9mdk9JMkRoKzJl?=
 =?utf-8?B?ZThjeHEzUkNCeURkY1NpN0hVWlhzaXJTTTVDSGZxMlc1eTk2Y1JFbE9EekRJ?=
 =?utf-8?B?NlN3Q1lBU1Awd0pGQi94R1pmcjUvUDVySWtnM2Jmeit2R2pGV1F6Q3JQeHF6?=
 =?utf-8?B?YmIvcHgzbGVGdVFFV0NTVmZsNlVITVFTeklYUW9lZFpwdkhuM1V0MUZMSmUx?=
 =?utf-8?B?VXVLZ3ZMa1AzT0pCb0hEVzROSUY2d1dKa0VuNTBQM3FQTXFFZ2pTOU51b0V6?=
 =?utf-8?B?UnNMUC9iYVBoTnZOMnN5dTJJTXNHZXZ5VUZqUEdpSjduaXM3OFlPU3lIZEc4?=
 =?utf-8?B?aVBCcUU2aThMT3FZZXJLakxGaXhDeGROaW9vRHRwRGJwdHp0akhQUmhKVFRI?=
 =?utf-8?B?N0lKVkFiT0ZkMG83S1dzcUUreVk2a09zMWluQTAxU2NDRlV2VkQrMklkdXNm?=
 =?utf-8?B?aHpka1Mvemd1QlBSTDZ3Qm9mYWMxeTFwRDVKblRya05QaWxidkdnM3ZrVytC?=
 =?utf-8?B?NWtqZ2hHVWowMkZvTndERVRvWE9MbHlOdmtTN2lyNjJER0VkU0pHcXZmS243?=
 =?utf-8?B?NmE2TE5WNThWb1JhMlVaNjgvVW81SFBEalhuejBUbGVGSEtjY2lEeTlSc3Vj?=
 =?utf-8?B?cGhLMnJoVTE2RW44VWlZMTNpVGMwZGY5VmYwR0ViZ0Uvdng0b1R5V2hPVldY?=
 =?utf-8?B?c2lySWp5QWRMUEVxb0tWMEd5dThUa2dQOCtFalhHS3N3VldBSHhjS1ZwaDZq?=
 =?utf-8?B?N1hyUTU5cGZVaGNDRzdYeVZvdTFWN2tMdzlaT1M3RitmaU5EQWt2TkxXclY3?=
 =?utf-8?B?eFFydUd4amVyWW0rRkdNNHZGN2ducFluejVHU2wzaitPcFc2TERmVzZ1d1NS?=
 =?utf-8?B?VG5FTmxaSWt2aTA5MXhjQVUvM1loQnZ5c0RLL0V6T3J5b053Qm96QVJtQ002?=
 =?utf-8?B?VFd0VThXUUs3YkhOZldOM3JSc1psS0FjdG1sN29pQ2RHUFpDWWh0bm9lZW5h?=
 =?utf-8?B?T2dJK3VtRUdiSkF1dE9FSmI2MEp6ellBYTRZYTV3b2lpeC81RXBQcTZYVTEv?=
 =?utf-8?B?MVlLM2NRWU0wTG8vWFBnb1ZkdEFKbGkzbEMxTU56N3ZJNTA0dG1BU3RkdlZN?=
 =?utf-8?B?WkdKbGNFYUtzMDZJbER2dUU2ZjYxeVI2cmNjdUFacVlhTHdWSzFBSnNiUGRD?=
 =?utf-8?B?Y2cvdmk1dFNSbXY2YzMxUVo0TGlzRjAzOWNVU2FGTmV5ODFKckJNVm5ITTVF?=
 =?utf-8?B?M2l3a3dUenNVS0pMbkJ1RVRrdStLa2VycHhPSFpmb2ZXSDJpNk00cG4yU0FW?=
 =?utf-8?B?cytPVFZ0MFVZME8yY296SnNycEdHN1BRd0dIRXdOQi9vcGJzTVRqMzZyVUxx?=
 =?utf-8?B?L25Rb2I2Vi9GNjIyb0lLSVlINHgzWmpkdTJNd0U0TjZaSHN4QlBVSUNGcHkr?=
 =?utf-8?B?dXUrWkJhVEtvbDhzNXpjMGdpWnc2UjZ4ZHU0QmVjM3BFRDdvOEY2akZML2E4?=
 =?utf-8?B?M2swcGtkNFhjeGY0a3NnWHZTcUZJdUtSS0FYWDh2akJaWjJhWDAvS0RhUVlh?=
 =?utf-8?B?OGxXc0s1aXVpMHRLZWhubUtSNXFsWkZjRnoxNFVqaUU2UUZETUh4aHlJZi9r?=
 =?utf-8?B?NVR1UFg4RHZrd1Q1cHBxWmgyeHZlaXRIQzBucUhCRUlwYXZmZHB4YnhWQUdp?=
 =?utf-8?B?RXZOUGx6empsdVBkMG03WVNpdkg4NEZ2dER3c0FGY3VYekd0V3MvYWVrRk02?=
 =?utf-8?B?QlhiR1RFaHg3SE9hMFhXd25odGJJNkw1US9hZVY4WVF0THhPNUpwN3p1MG1h?=
 =?utf-8?B?NTVYb1ZpMHF1WmZHMFA4WDJVSlJZSmdMTEdCTWVhSUo1QkZTTHVsTDJFbHJi?=
 =?utf-8?B?aDZTRDRDTDVESVZWTzNubWxMNFlhUXI3S2hQcXRkUlM4cjAzb1ZaWmY2c0lF?=
 =?utf-8?Q?TJoeJys0khosywhGHa4Kwwo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf0bee0-e761-42a2-99b5-08db5558a281
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 15:25:37.4874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sOqJ9dpwzn3nBIBq0+hSIasp0BdpARdjTG0HVsKMkVnbKj1UHK5QpvXDTtrwGXug7uR4ecz+G9lSGJS+97k1eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5956
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v2 0/2] transport-pci: Introduce
 legacy registers access using AQ

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIE1heSAxMSwgMjAyMyAzOjIxIEFNDQo+IA0KPiBPbiBUaHUsIE1heSAxMSwgMjAyMyBh
dCAxMjowOOKAr0FNIFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4N
Cj4gPg0KPiA+DQo+ID4gT24gNS8xMC8yMDIzIDEyOjIyIEFNLCBKYXNvbiBXYW5nIHdyb3RlOg0K
PiA+ID4gT24gV2VkLCBNYXkgMTAsIDIwMjMgYXQgMTE6NTHigK9BTSBKYXNvbiBXYW5nIDxqYXNv
d2FuZ0ByZWRoYXQuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+ID4NCj4gPiA+IEp1c3QgdG8gbWFr
ZSBzdXJlIHdlIGFyZSBhdCB0aGUgc2FtZSBwYWdlLg0KPiA+ID4NCj4gPiA+IDEpIGlmIHRoZSBo
YXJkd2FyZSBoYXMgY29uZmlncSBhbmQgd2UgbmVlZCB0byBtYWtlIGl0IHdvcmsgZm9yDQo+ID4g
PiBjdXJyZW50IHZpcnRpby1wY2kgZHJpdmVyLCBoeXBlcnZpc29yIG5lZWRzIHRvIHRyYXAgZ3Vl
c3QgUENJIGFjY2Vzcw0KPiA+ID4gYW5kIHRyYW5zbGF0ZSBpdCB0byBjb25maWdxIGNvbW1hbmQu
IFRoaXMgbWVhbnMgdGhlIGh5cGVydmlzb3IgbmVlZHMNCj4gPiA+IHRvIGhpZGUgdGhlIGNvbmZp
Z3EgZnJvbSBndWVzdHMuIEluIHRoaXMgY2FzZSB0aGUgY29uZmlncSBuZWVkcyBhDQo+ID4gPiBk
ZWRpY2F0ZWQgRE1BIGFkZHJlc3Mgd2hpY2ggaXMgd2hhdCBQQVNJRCBjYW4gaGVscC4NCj4gPg0K
PiA+ID4gMikgaWYgdGhlIGhhcmR3YXJlIGNhbiByZXBvcnQgdGhlIGRldmljZSBzdGF0ZXMsIHVu
bGVzcyB3ZSB3YW50IHRvDQo+ID4gPiBtaWdyYXRlIEwyIGd1ZXN0LCBoeXBlcnZpc29yIHNob3Vs
ZCBoaWRlIGl0IGZyb20gTDEsIHNvIFBBU0lEIGlzDQo+ID4gPiByZXF1aXJlZCB0byBpc29sYXRl
IHRoZSBETUEgZm9yIGd1ZXN0IHRyYWZmaWMgYW5kIGRldmljZSBzdGF0ZS4NCj4gPg0KPiA+IEEg
Y29uZmlncSBuZWdvdGlhdGVzICsgZGlzY292ZXJzIG5ldyBmaWVsZHMgZm9yIHRoZSBQQ0kgUEYs
IFZGLA0KPiA+IFNGL1NJT1YgZGV2aWNlcyBvdmVyIFBDSWUgb3Igb3RoZXIgdHJhbnNwb3J0cy4N
Cj4gPiBTbyBubyBuZWVkIHRvIGhpZGUvbWVkaWF0ZSBmb3IgaHcgYmFzZWQgZGV2aWNlcywgbGlr
ZSBjdnEgYW5kIGxpa2UgZGF0YSB2cXMuDQo+IA0KPiBBcyBkaXNjdXNzZWQsIEkgbWF5IG1pc3Vu
ZGVyc3RhbmQgdGhlIGZ1bmN0aW9uIG9mIHRoZSBjb25maWdxLiBJZiBpdCB3b3JrcyBsaWtlDQo+
IGN2cSwgdGhlbiB5ZXMuIFdlIGRvbid0IG5lZWQgUEFTSUQuDQo+IA0KUmlnaHQuDQoNCj4gQnV0
IGlmIHdlIHdhbnQgdG8gcmVwb3J0IGRldmljZSBzdGF0ZSB2aWEgbGV0J3Mgc2F5IG1pZ3JhdGlv
biBxLCBpdCByZXF1aXJlcyBQQVNJRA0KPiBzaW5jZSBpdCBpcyB1c2VkIGJ5IHRoZSBoeXBlcnZp
c29yLg0KDQpXaGVuIGEgZGV2aWNlIGlzIHVzZWQgYXMgcGFzc3Rocm91Z2gsIHVzdWFsbHkgdGhl
IG93bmVyIGdyb3VwIG1lbWJlciB3b3VsZCBwZXJmb3JtIHRoZSBkZXZpY2Ugc3RhdGUgbWFuYWdl
bWVudC4NCkhlbmNlIHBhc3N0aHJvdWdoIG1vZGUgd2lsbCBub3QgdXNlIHBhc2lkLg0KDQpXaGVu
IGRldmljZSBpcyBtZWRpYXRlZCBpbiBIViwgeWVzIFBBU0lEIG1heSBiZSBuZWVkZWQgdG8gaXNv
bGF0ZSB0aGUgRE1BIG9mIGh5cGVydmlzb3IgZnJvbSB0aGUgZ3Vlc3QuDQo=

