Return-Path: <virtio-dev-return-14230-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56188C47258
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 07:48:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 92D532AF8C
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 07:48:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 72370986468
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 07:48:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 541B498403A; Mon, 15 Jan 2024 07:48:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4524E986367;
	Mon, 15 Jan 2024 07:48:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIijw4s3P7jVFdcpseef102iopyK7W/hvVe+aMzck48fggQ0LF5Y4gASyYVFm0BbCFByM2gii/2wFNwek241WSXIVT+qknOXNak00omL3OHZkOQ87QcqjgxqPn1Ly/du4CaXJCDVd/OyKA/SnbEgwgu95TWR0GWZ8GhhmFHdRARiC+sVCALK9ADV9/GmQOIPuU2+gilVT+MpFp+HD10T32OobahHEhtDuCYkIaCrQ9QQD6ovFDA7mh8OCly/NRdu0tKDMRtexipcsWEyO+qnc9cuCV9cipyflyjrf51DoQ13l2vkuo+oQxFv1q0Z39tomFyJNorvB/8Cik6KynVW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qpT2BuhdqFQPmGHMkmSAyRwdPLbLnGDxEWPM4x17aY=;
 b=RyyZ0t6fYGyTx+qDst3mqWu4SmGlQSSudW5X3TTpJeMygCOZtrGXEi/aIu30ZaQmNvKXynf2JIEw9mIUGeEpeouDNixoZPHP0lVaikrzHtt7QpTIzNb8cM78OaAP0zMc1LxfZJu6lS485Dkb4545fMP4syFKld0cclp5zubWXgweTZjSyUyCtP+m34AoKDeJPrN3JIvb9zXlg6hezsl6se52B/dQrUdEkL10x2VAU39Q7ZV1b33C1c3nuN3JJDNOD8AQpchhX3TaDTBzAlnWJUSR74CcKKf9U8xDdl75n2pBnMSdWApWbMkc8GRMyKntk7fICYEnpQ5AfZ7bj8SgWQ==
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
 AQHaA9HvmHelxVzMEkK9DIiJvUqDjbBW5OUAgAC5UoD//8WsgIAB4oYA//+CG4CAAI+hgIAAjVeAgAJwQAD//5FqAAAzXyGADyowGYD//4AlgIAAia6A//+C6oCAAItHgP//hKUAgAUWT4D//31GAAAQ5xwA
Date: Mon, 15 Jan 2024 07:48:17 +0000
Message-ID:
 <BL1PR12MB5849F3E85F2661EB38128A67E76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20231021035111.650248-1-Jiqian.Chen@amd.com>
 <PH0PR12MB5481A43D8E5A0F580B785E1EDCDEA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB58498946F163AFE8AFE7DF94E7DDA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <20231026062805-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849D7936DD77FECD1FE971EE7DCA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <BL1PR12MB58499AD7442C0A9FC400D747E76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481553C8461B7F1F047B5D3DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB58492CAC080A708809E434B0E76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481AD6A2E262A419FA2CBA8DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584943FA1C20BBF618EBB73AE76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481BB80679107D8E0167954DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584952204D1C8AD579F8A87CE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB548102E41B13AAB57C7321FCDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To:
 <PH0PR12MB548102E41B13AAB57C7321FCDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: IA1PR12MB8495.namprd12.prod.outlook.com
 (15.20.7181.004)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|CYXPR12MB9441:EE_
x-ms-office365-filtering-correlation-id: ebfb6f88-70d8-42c4-b701-08dc159e56b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ZUNhFJWiV36TAtk9CO2goyLGRABBBfBmqx8DQiViEjN6GoUtFRkO+utKbZF6oiihx9/I3tYZD7b4q+YeV1X4pkTcLXmXjvKcKcCbrnonUVFwT+3JJNTfvJDZEoRdSkb28gECMLY3qD30yHIF8CfRcx+3I0tLPLXmaJItbptqgm7wirCy0gCrLLmtPb+cb9C6/ncKr0DRiid/ag4ar9b4BT4wcUW9nZIczNXhIqLROrSdM0cl9AS5/ikxLceckEuun1Jj84X4CTA+timsLtdZ+F42m8Zp72cMO1zHoQK788Umgr0vRSpA3vC55hMEU4h10cNEXA7hRBN/ksGqaJmETR2icUDds+NZ7SxDurp7QjaaJ7EYKxdT6nUU5PdpmmC4909EPQx8YXXOv5u07fBTnuumhXFsT+oFI9z66NxYLa4P1ojc0opHgRseVajNxSsH+KO9Hz1nghiWNK2DR1fog9He0D1hkcgaMLFk/9kQtwp9B/aC6c718C2DH8Bp7/afHcPxA6PBglZx+ZymOHhSeRdR523cb5vTn8L7kbzn7F/QR9OzUWartdyhKyUHhJ1FhqbRv0q1JbMKuYC3Snn+HahYiUjlbrU3HoQtWpELvmzykjmP6TPK6J2he32Vg9r9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(39860400002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(66899024)(7696005)(6506007)(9686003)(83380400001)(26005)(53546011)(71200400001)(38070700009)(38100700002)(122000001)(33656002)(41300700001)(478600001)(8676002)(8936002)(52536014)(4326008)(5660300002)(66946007)(76116006)(66476007)(66556008)(55016003)(6916009)(316002)(2906002)(66446008)(54906003)(7416002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q3dQWXVXcHBOREtDQmxLdFJ0L1JncUJsM0k1NnRyeUxaZ2pxZnZNZW9zTGFr?=
 =?utf-8?B?UE1NcUY2SUllL29ka0V6dkRNbHNvKzJBR3pVSUlGQjNuaEZjQzEzQ0d1N1Ji?=
 =?utf-8?B?V0ZvMzBXc0l5endIVzZ3ZXlyRXlVSFByM2pkWTVhNWpxKzJKUVY2UGJKN1dJ?=
 =?utf-8?B?dE4xMGlCY0dUbTZvNnFQa3lOZHpiWCtoNnYrcjN6NjhlTzY3c2ZIaFRMNHV0?=
 =?utf-8?B?cUNEc01JR2Q3dmtSK3BQcG9tS2lYZ05FdmdJSWhSTWJLZkxtOHBncEw4RjJP?=
 =?utf-8?B?RnR3ejBDWldQOE1reldRNjZxemhWTnhGbE1neWwxUVEyN3Vxa2w0N0ppV2Zz?=
 =?utf-8?B?Ym5UaUFTSVpXMDFlMk9BMEQ2Q3lmVC9tc2h6dmRPU1ZwTnVtTTBaZGF4ejR4?=
 =?utf-8?B?amh1UWY0Z2R6Rjk5eXpaakdUT2hiVHRJUW0rNDMwdnpwMTV6M2RBQ3lZaTE3?=
 =?utf-8?B?aU5lS2hsZlFpMlFuV1VaWHVwL3N2eTlWYTgvV1lYdm5VTEVuSmszVW5qRVVQ?=
 =?utf-8?B?U0wrZDBTcFZBVnk3K0tMVHZwYjBPUS9SQ0ZDSXVyczR3UVlpdzAveEx4ME1Z?=
 =?utf-8?B?ZkFWMmhzMTVqK2NTVmdpdWREb0ZQK0JDdmM0UExvVitqeTZRbVQyNlVsV0hh?=
 =?utf-8?B?a3hoSlNrNVFIMitYRDJvZ1ZVMzl1VEpBOEhpL09kRmZIMnZ4K2JXa0VKM2xF?=
 =?utf-8?B?dXZpNC9wK3ZXUmdlUXBlN05YUGczWGRCbFdLbzYwdk81MytwbEhkb1lFVGxX?=
 =?utf-8?B?NUI2RVdDOUVkcWlnRFJzbnFVOVI3SmQxZzJxWEFzcm9PUE5OREg5M1dmd3pG?=
 =?utf-8?B?VlNkMm5LZnVYTjZORDU3aFg3cCs4OUgxOXltOXBVUFFzaG90aXliVVAvRFRS?=
 =?utf-8?B?RVBTQjlTN0c2WEZWeENUTUErUFNyelNPY1ErbnpQVWZLR3NKK3dEUnhSWDV2?=
 =?utf-8?B?Q2JTa1BDelRrK1N3cGVpR0NNU2tDMWZ1Ykl1dGxEU2tMNjFRREcwZVo3UHNm?=
 =?utf-8?B?SkVScjExZTdsY3BiUWdXZVl2MUdnbllQalRsRk4vK3dCQmlsV29tNUQvMlVC?=
 =?utf-8?B?bitKWGhoV3hMVCttNU41dTV4MW1NQzFEeThLck1Ldm55Y3BEeVVRWm1VWWgr?=
 =?utf-8?B?cG45cmtpVnhYQjI0VjVaZGszZDlpZ21RbUlsWHRVWFNSc2R6UWtwcS9jK0cx?=
 =?utf-8?B?TFlnZjBMa2xkUnhOam9KVjl3TlhmcFhmREVrclNrVkl2RlIzSFNwa2J5akhu?=
 =?utf-8?B?SDY4S0dRWXpHeFhoY0FPRGZDWXlDQVZaRi9tcEpFSml1K3dBTGRnYkhKT28v?=
 =?utf-8?B?cEhPUE9RNlJTaStNQUU2a0dWS254VmZRbXJhamxtcjZ1U1pwTjN0eTFQSGNX?=
 =?utf-8?B?ajdMUHhwOGppa3pvLzViQlp1RjZEVXVlWUtacDJRT3poQlZ1YTVacEtZYlFM?=
 =?utf-8?B?L3dkK1VyTDlEd3I5UmFtT09YVnhsNkNUd2JOUkhjZFVmZHpjNlRlTDYvZWVM?=
 =?utf-8?B?MEl4d2U1eWtVVHlQUWdrR3ZPOWd1WS9BeExWZzBuVGNUT2VGcnVycFJ3bDV4?=
 =?utf-8?B?ME83ZEtEQ25WdGh2U2VtSlJ3NldyTWRrMG9MdFV0V3ozc3hRdVMrTVF2OStt?=
 =?utf-8?B?NzZtTkZWSVhuQ2tnNCsydktZdnlUOUVYUHNsWlBjaUpFL3FxdTViVmRZbHhK?=
 =?utf-8?B?c3g3anVuUnUwQUpJVFlKRWNYMENsRVdSMk1LcHQ3QmtOMjRNK1J0SUIxZzJv?=
 =?utf-8?B?U1VyeksxUlBkcHM5UEJyeVpRcVF1MEFlNTlpYTRJdjhpdDM4Ny9teDY5L3lW?=
 =?utf-8?B?YTVJMjR3NFBXc0pPbDl3ejdYSDlNSkRyMXRwRlUrdmE2ZEg1bStGcjhsd3I0?=
 =?utf-8?B?K2NwazJYaUxWWnMxNnlOeDYvUFYzSDRYMHhHNElmMFNIV0I4SVA1VGYzNlRh?=
 =?utf-8?B?OXRwWGR3SUtlZ2pJeHY0Q0ZJK3BHYjg2Y1RqTWxBeDAvY3BIbmhGYnlKeU1Z?=
 =?utf-8?B?b1NIV1dkdnYzdjFXWjgxbUJFcTJwR0Y2ZUJhMVZyRjZCcDJjbm0wQThBMkpX?=
 =?utf-8?B?OWpXeDAvR3h5dkpDOTQxZXkzSDNFUVdBWks3TGRQVU5ETjhzc3NmS1o1T25x?=
 =?utf-8?Q?Uiv4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCCF6D5A556EDB44B9A8FF8CDF68A409@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfb6f88-70d8-42c4-b701-08dc159e56b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 07:48:17.9348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uyXmeU2LiAdN0FWdHYsZK58dicOUzMHWOh4YuXiqrtYgHeID6QM7vb1aQw570F7yrYvyskRskLf03UMoifmjYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES

T24gMjAyNC8xLzE1IDE1OjM3LCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+IA0KPj4gRnJvbTogQ2hl
biwgSmlxaWFuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KPj4gU2VudDogTW9uZGF5LCBKYW51YXJ5
IDE1LCAyMDI0IDE6MDMgUE0NCj4+DQo+PiBPbiAyMDI0LzEvMTIgMTc6NDQsIFBhcmF2IFBhbmRp
dCB3cm90ZToNCj4+Pg0KPj4+DQo+Pj4+IEZyb206IENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5A
YW1kLmNvbT4NCj4+Pj4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDEyLCAyMDI0IDI6NTUgUE0NCj4+
Pj4NCj4+Pj4gT24gMjAyNC8xLzEyIDE2OjQ3LCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+Pj4+Pg0K
Pj4+Pj4NCj4+Pj4+PiBGcm9tOiBDaGVuLCBKaXFpYW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+
Pj4+Pj4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDEyLCAyMDI0IDE6NTUgUE0NCj4+Pj4+Pg0KPj4+
Pj4+DQo+Pj4+Pj4gT24gMjAyNC8xLzEyIDE2OjAyLCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+Pj4+
Pj4+IEhpIEppcWlhbiwNCj4+Pj4+Pj4NCj4+Pj4+Pj4+IEZyb206IENoZW4sIEppcWlhbiA8Smlx
aWFuLkNoZW5AYW1kLmNvbT4NCj4+Pj4+Pj4+IFNlbnQ6IEZyaWRheSwgSmFudWFyeSAxMiwgMjAy
NCAxOjExIFBNDQo+Pj4+Pj4+DQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gSGkgYWxsLA0KPj4+Pj4+Pj4g
U29ycnkgdG8gcmVwbHkgbGF0ZS4NCj4+Pj4+Pj4+IEkgZG9uJ3Qga25vdyBpZiB5b3Ugc3RpbGwg
cmVtZW1iZXIgdGhpcyBwcm9ibGVtLCBsZXQgbWUgYnJpZWZseQ0KPj4+Pj4+Pj4gZGVzY3JpcHQN
Cj4+Pj4gaXQuDQo+Pj4+Pj4+PiBJIGFtIHdvcmtpbmcgdG8gaW1wbGVtZW50IHZpcnRncHUgUzMg
ZnVuY3Rpb24gb24gWGVuLg0KPj4+Pj4+Pj4gQ3VycmVudGx5IG9uIFhlbiwgaWYgd2Ugc3RhcnQg
YSBndWVzdCB0aHJvdWdoIHFlbXUgd2l0aCBlbmFibGluZw0KPj4+Pj4+Pj4gdmlydGdwdSwgYW5k
IHRoZW4gc3VzcGVuZCBhbmQgcmVzdW1lIGd1ZXN0LiBXZSBjYW4gZmluZCB0aGF0IHRoZQ0KPj4+
Pj4+Pj4gZ3Vlc3Qga2VybmVsIGNvbWVzIGJhY2ssIGJ1dCB0aGUgZGlzcGxheSBkb2Vzbid0LiBJ
dCBqdXN0IHNob3duIGENCj4+Pj4+Pj4+IGJsYWNrDQo+Pj4+Pj4gc2NyZWVuLg0KPj4+Pj4+Pj4g
VGhhdCBpcyBiZWNhdXNlIGR1cmluZyBzdXNwZW5kaW5nLCBndWVzdCBjYWxsZWQgaW50byBxZW11
IGFuZA0KPj4+Pj4+Pj4gcWVtdSBkZXN0cm95ZWQgYWxsIGRpc3BsYXkgcmVzb3VyY2VzIGFuZCBy
ZXNldCByZW5kZXJlci4gVGhpcw0KPj4+Pj4+Pj4gbWFkZSB0aGUgZGlzcGxheSBnb25lIGFmdGVy
IGd1ZXN0IHJlc3VtZWQuDQo+Pj4+Pj4+PiBTbywgSSBhZGQgYSBuZXcgY29tbWFuZCBmb3Igdmly
dGlvLWdwdSB0aGF0IHdoZW4gZ3Vlc3QgaXMNCj4+Pj4+Pj4+IHN1c3BlbmRpbmcsIGl0IHdpbGwg
bm90aWZ5IHFlbXUgYW5kIHNldA0KPj4+Pj4+Pj4gcGFyYW1ldGVyKHByZXNlcnZlcl9yZXNvdXJj
ZSkgdG8gMSBhbmQgdGhlbiBxZW11IHdpbGwgcHJlc2VydmUNCj4+Pj4+Pj4+IHJlc291cmNlcywg
YW5kIHdoZW4gcmVzdW1pbmcsIGd1ZXN0IHdpbGwgbm90aWZ5IHFlbXUgdG8gc2V0DQo+Pj4+Pj4+
PiBwYXJhbWV0ZXIgdG8gMCwgYW5kIHRoZW4gcWVtdSB3aWxsIGtlZXAgdGhlIG5vcm1hbCBhY3Rp
b25zLiBUaGF0DQo+Pj4+Pj4+PiBjYW4NCj4+Pj4gaGVscCBndWVzdCdzIGRpc3BsYXkgY29tZSBi
YWNrLg0KPj4+Pj4+Pj4gV2hlbiBJIHVwc3RyZWFtIGFib3ZlIGltcGxlbWVudGF0aW9uLCBQYXJh
diBhbmQgTVNUIHN1Z2dlc3QgbWUNCj4+IHRvDQo+Pj4+Pj4gdXNlDQo+Pj4+Pj4+PiB0aGUgUE0g
Y2FwYWJpbGl0eSB0byBmaXggdGhpcyBwcm9ibGVtIGluc3RlYWQgb2YgYWRkaW5nIGEgbmV3DQo+
Pj4+Pj4+PiBjb21tYW5kIG9yIHN0YXRlIGJpdC4NCj4+Pj4+Pj4+IE5vdywgSSBoYXZlIHRyaWVk
IHRoZSBQTSBjYXBhYmlsaXR5IG9mIHZpcnRpby1ncHUsIGl0IGNhbid0IGJlDQo+Pj4+Pj4+PiB1
c2VkIHRvIHNvbHZlIHRoaXMgcHJvYmxlbS4NCj4+Pj4+Pj4+IFRoZSByZWFzb24gaXM6DQo+Pj4+
Pj4+PiBkdXJpbmcgZ3Vlc3Qgc3VzcGVuZGluZywgaXQgd2lsbCB3cml0ZSBEMyBzdGF0ZSB0aHJv
dWdoIFBNIGNhcCwNCj4+Pj4+Pj4+IHRoZW4gSSBjYW4gc2F2ZSB0aGUgcmVzb3VyY2VzIG9mIHZp
cnRpby1ncHUgb24gUWVtdSBzaWRlKHNldA0KPj4+Pj4+Pj4gcHJlc2VydmVyX3Jlc291cmNlIHRv
IDEpLCBidXQgZHVyaW5nIHRoZSBwcm9jZXNzIG9mIHJlc3VtaW5nLCB0aGUNCj4+Pj4+Pj4+IHN0
YXRlIG9mIFBNIGNhcCB3aWxsIGJlIGNsZWFyZWQgYnkgcWVtdQ0KPj4+Pj4+Pj4gcmVzZXR0aW5n
KHFlbXVfc3lzdGVtX3dha2V1cC0+IHFlbXVfZGV2aWNlc19yZXNldC0+DQo+Pj4+Pj4+PiB2aXJ0
aW9fdmdhX2Jhc2VfcmVzZXQtPiB2aXJ0aW9fZ3B1X2dsX3Jlc2V0KSwgaXQgY2F1c2VzIHRoYXQg
d2hlbg0KPj4+Pj4+Pj4gZ3Vlc3QgcmVhZHMgc3RhdGUgZnJvbSBQTSBjYXAsIGl0IHdpbGwgZmlu
ZCB0aGUgdmlydGlvLWdwdSBoYXMNCj4+Pj4+Pj4+IGFscmVhZHkgYmVlbiBEMCBzdGF0ZSwNCj4+
Pj4+Pj4gVGhpcyBiZWhhdmlvciBuZWVkcyB0byBiZSBmaXhlZC4gQXMgdGhlIHNwZWMgbGlzdGVk
IG91dCwgIiBUaGlzDQo+Pj4+Pj4+IDItYml0IGZpZWxkIGlzDQo+Pj4+Pj4gdXNlZCBib3RoIHRv
IGRldGVybWluZSB0aGUgY3VycmVudCBwb3dlciBzdGF0ZSBvZiBhIEZ1bmN0aW9uIg0KPj4+Pj4+
IERvIHlvdSBtZWFuIGl0IGlzIHdyb25nIHRvIHJlc2V0IFBNIGNhcCB3aGVuIHZyaXRpb19ncHUg
cmVzZXQgaW4NCj4+Pj4+PiBjdXJyZW50IHFlbXUgY29kZT8gV2h5Pw0KPj4+Pj4gQmVjYXVzZSBQ
TSBpcyBpbXBsZW1lbnRpbmcgdGhlIHN1cHBvcnQgZnJvbSBEMy0+ZDAgdHJhbnNpdGlvbiBhbmQg
aWYNCj4+Pj4+IGl0DQo+Pj4+IGRldmljZSBpbiBEMywgdGhlIGRldmljZSBuZWVkcyB0byByZXNw
b25kIHRoYXQgaXQgaXMgaW4gRDMgdG8gbWF0Y2gNCj4+Pj4gdGhlIFBDSSBzcGVjLg0KPj4+Pj4N
Cj4+Pj4+PiBTaG91bGRuJ3QgYWxsIGRldmljZSBzdGF0ZXMsIGluY2x1ZGluZyBQTSByZWdpc3Rl
cnMsIGJlIHJlc2V0DQo+Pj4+Pj4gZHVyaW5nIHRoZSBwcm9jZXNzIG9mIHZpcnRpby1ncHUgcmVz
ZXQ/DQo+Pj4+PiBJZiBOb19Tb2Z0X1Jlc2V0PT0gMCwgbm8gZGV2aWNlIGNvbnRleHQgdG8gYmUg
cHJlc2VydmVkLg0KPj4+Pj4gSWYgTm9fU29mdF9SZXNldCA9PSAxLCBkZXZpY2UgdG8gcHJlc2Vy
dmUgbWluaW1hbCByZWdpc3RlcnMgYW5kDQo+Pj4+PiBvdGhlcg0KPj4+PiB0aGluZ3MgbGlzdGVk
IGluIHBjaSBzcGVjLg0KPj4+Pj4NCj4+Pj4+Pg0KPj4+Pj4+Pg0KPj4+Pj4+PiBTbyBkZXZpY2Ug
bmVlZHMgdG8gcmV0dXJuIEQzIGluIHRoZSBQb3dlclN0YXRlIGZpZWxkLiAgVGhpcyBpcyBtdXN0
Lg0KPj4+Pj4+IEJ1dCBjdXJyZW50IGJlaGF2aW9yIGlzIGEga2luZCBvZiBzb2Z0IHJlc2V0LCBJ
DQo+Pj4+Pj4gdGhpbmsoIVBDSV9QTV9DVFJMX05PX1NPRlRfUkVTRVQpLiBUaGUgcG0gY2FwIGlz
IHJlc2V0IGJ5IHFlbXUgaXMNCj4+Pj4+PiByZWFzb25hYmxlLg0KPj4+Pj4gV2hhdCB5b3UgZGVz
Y3JpYmVkIGlzLCB5b3UgbmVlZCB0byBkbyBOb19Tb2Z0X1Jlc2V0PTEsIHNvIHBsZWFzZSBzZXQN
Cj4+Pj4+IHRoZQ0KPj4+PiBjYXAgYWNjb3JkaW5nbHkgdG8gYWNoaWV2ZSB0aGUgcmVzdG9yZS4N
Cj4+Pj4+DQo+Pj4+PiBBbHNvIGluIHlvdXIgY2FzZSB0aGUgaWYgdGhlIFFFTVUga25vd3MgdGhh
dCBpdCB3aWxsIGhhdmUgdG8gcmVzdW1lDQo+Pj4+PiB0aGUNCj4+Pj4gZGV2aWNlIHNvb24uDQo+
Pj4+PiBIZW5jZSwgaXQgY2FuIHdlbGwgcHJlcGFyZSB0aGUgZ3B1IGNvbnRleHQgYmVmb3JlIHJl
c3VtaW5nIHRoZSB2Y3B1cy4NCj4+Pj4+IEluIHN1Y2ggY2FzZSwgdGhlIGV4dHJhIHJlZ2lzdGVy
IHdvdWxkbuKAmXQgYmUgbmVjZXNzYXJ5Lg0KPj4+Pj4gSGF2aW5nIFBNIGNvbnRyb2wgcmVnaXN0
ZXIgaXMgYW55d2F5IG5lZWRlZCB0byBkcml2ZSB0aGUgZGV2aWNlIHByb3Blcmx5Lg0KPj4+PiBF
dmVuIGFzIHlvdSBzYWlkLCB0aGUgcmVzZXQgYmVoYXZpb3Igb2YgUE0gaW4gdGhlIGN1cnJlbnQg
UUVNVSBjb2RlDQo+Pj4+IGlzIGluY29ycmVjdCwgYW5kIGV2ZW4gaWYgaXQgaXMgbW9kaWZpZWQs
IGl0IGFsc28gY2Fubm90IGZpeCB0aGlzIHByb2JsZW0gd2l0aCBTMy4NCj4+PiBZb3UgbWVhbnQg
RDM/DQo+Pj4NCj4+Pj4gQmVjYXVzZSB0aGVyZSBpcyB0d2ljZSBkZXZpY2UgcmVzZXQgZHVyaW5n
IHJlc3VtaW5nLg0KPj4+PiBGaXJzdCBpcyB3aGVuIHdlIHRyaWdnZXIgYSByZXN1bWUgY29tbWFu
ZCB0byBxZW11LCBxZW11IHdpbGwgcmVzZXQNCj4+Pj4gZGV2aWNlKHFlbXVfc3lzdGVtX3dha2V1
cC0+IHFlbXVfZGV2aWNlc19yZXNldC0+DQo+Pj4+IHZpcnRpb192Z2FfYmFzZV9yZXNldC0+IHZp
cnRpb19ncHVfZ2xfcmVzZXQpLg0KPj4+IEEgZGV2aWNlIGltcGxlbWVudGF0aW9uIHRoYXQgc3Vw
cG9ydHMgUE0gc2hvdWxkIG5vdCByZXNldCB0aGUgZGV2aWNlLg0KPj4gUGxlYXNlIGZpeCBpdC4N
Cj4+IERvIHlvdSBtZWFuIHRoZSBkZXZpY2VzX3Jlc2V0IGJlaGF2aW9yIG9mIHFlbXUgc2hvdWxk
bid0IGhhcHBlbiB3aGVuIGENCj4+IGRldmljZSBoYXMgUE0gY2FwPw0KPiBSaWdodC4gRGV2aWNl
IHJlc2V0IHNob3VsZCBub3QgaGFwcGVuIG9uIFBNIGNhcGFibGUgZGV2aWNlIHRoYXQgb2ZmZXJz
IG5vX3NvZnRfcmVzZXQ9PTEuDQpCdXQgY3VycmVudCBxZW11IGNvZGUsIG5vX3NvZnRfcmVzZXQ9
PTAuDQoNCj4gDQo+PiBPciBqdXN0IHRoZSBzdGF0ZSBvZiBQTSBjYXAgc2hvdWxkbid0IGJlIHJl
c2V0Pw0KPj4NCj4+Pg0KPj4+PiBBZnRlciB0aGUgZmlyc3QgdGltZSwgdGhlbiBzZWNvbmQgdGlt
ZSBoYXBwZW5zIGluIGd1ZXN0IGtlcm5lbCwNCj4+Pj4gdmlydGlvX2RldmljZV9yZXN0b3JlLT4g
dmlydGlvX3Jlc2V0X2RldmljZS4gQnV0IHRoZSBQTSBzdGF0ZSBjaGFuZ2VzDQo+Pj4+IChEMyB0
bw0KPj4+PiBEMCkgaGFwcGVucyBiZXR3ZWVuIHRob3NlIHR3bywgc28gdGhlIGRpc3BsYXkgcmVz
b3VyY2VzIHdpbGwgYmUgc3RpbGwNCj4+Pj4gZGVzdHJveWVkIGJ5IHRoZSBzZWNvbmQgdGltZSBv
ZiBkZXZpY2UgcmVzZXQuDQo+Pj4gVGhlIGRyaXZlciB0aGF0IHVuZGVyc3RhbmRzIHRoYXQgZGV2
aWNlIHN1cHBvcnRzIFBNLCB3aWxsIHNraXAgdGhlIHJlc2V0DQo+PiBzdGVwcy4NCj4+IEJ1dCBp
dCBoYXBwZW5zIGZvciBub3cuDQo+IFRoaXMgc2hvdWxkIGJlIGVuaGFuY2VkIGluIHRoZSBndWVz
dCBkcml2ZXIuDQo+IA0KPj4gSW4gY3VycmVudCBxZW11IGNvZGVzLCB0aGUgYml0IFBDSV9QTV9D
VFJMX05PX1NPRlRfUkVTRVQgb2YgdmlydGlvLXBjaQ0KPj4gZGV2aWNlcyBpc24ndCBzZXQsIGlz
IGl0IGEgYnVnPyBJdCBtZWFucyB0aGUgbm9fc29mdF9yZXNldD09MC4NCj4+DQo+IEl0IHNob3Vs
ZCBiZSBzZXQgd2hlbi9pZiB0aGUgZGV2aWNlIGNhbiBzdG9yZSBhbmQgcmVzdG9yZSB0aGUgZGV2
aWNlIGNvbnRleHQgb24gZDMtPmQwIHRyYW5zaXRpb24uDQpJIGRvbid0IGtub3cgd2h5IGl0IGRv
ZXNuJ3QgYmUgc2V0IGluIGN1cnJlbnQgcWVtdSBjb2RlLg0KV2hhdCBkbyB5b3UgbWVhbiAidGhl
IGRldmljZSBjYW4gc3RvcmUgYW5kIHJlc3RvcmUgdGhlIGRldmljZSBjb250ZXh0IG9uIGQzLT5k
MCB0cmFuc2l0aW9uIj8gVGhlIHJlYWwgcGh5c2ljYWwgZGV2aWNlIG9yIHRoZSBzaW11bGF0ZWQg
ZGV2aWNlcyBvbiBxZW11IHNpZGU/DQpIb3cgZG8gSSBjb25maXJtIGl0Pw0KDQo+IA0KPj4+IEhl
bmNlIHRoZSAybmQgcmVzZXQgd2lsbCBhbHNvIG5vdCBvY2N1ci4NCj4+PiBUaGVyZWZvcmUsIGRl
dmljZSBzdGF0ZSB3aWxsIGJlIHJlc3RvcmVkLg0KPj4NCj4+IC0tDQo+PiBCZXN0IHJlZ2FyZHMs
DQo+PiBKaXFpYW4gQ2hlbi4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpKaXFpYW4gQ2hlbi4NCg==

