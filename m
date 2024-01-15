Return-Path: <virtio-dev-return-14236-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648B3C47422
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 09:40:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BBA572CADD
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 09:40:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AD1B998658B
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 09:40:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 97F5F9863A8; Mon, 15 Jan 2024 09:40:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 83798986367;
	Mon, 15 Jan 2024 09:40:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbuzAqnkNkLyh5E8MuTt3BUss8PX19ELZ1eDXW46IBg5oAmsxkyU/DSLV0k/f/mPaoOpvMCqRqUxm4MhgmZnn5Jy/S0pXrYY4f1wyofDn8uWW9UKlBFe1+eG/B0X//ou/BIQkXrluNCMcmis+ElXu5NAukBrH6BiL/PyIigS7DM/3O06Lzr/OLsf5JS1j9D/3R+r8nLmivwp6QtqrZ6aoGjCwmJg07bUtwKPsg7BR4mclXUYuMVoM8w5M9gnZkEmd11jQ0RCIZVQxKevydAkDObZP5TGW9LHDL8j97n7OH10YtRGZlzq6gg9UFrKBZ1KN4VFP23rN37O/HLjbk75Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwIMnTCP19eBYxRSiRcrAtySeYD1eumkF7eT/8zpuBo=;
 b=oQl+KbJWQ/fz3KvmTILBc7izi7iq3ZnnDIrRclBNfFQ6QnVH0FqcNzblbE+iJGXhwT9g5MBg1YyrQLsAEjHql9aF5Ae+VtZnkN7byXuEo3S/eWlHhmpbF3bGQrTI0XqBiW5DsM1rEuWEbqyme/eHvnv3i7YlzeGuAzagvl+b4NDp7xZUJCTrle51B9Uzj4lbQORlnVjcA1hV81YsZvUXZBIiurkSy593B58kRFv6NoiA+C8V26mebr0winDJtLv7FZDtvpAHHCzr6c1klDIyCjtlkbsFL3nKCrfAlZzFoNSAXhcc1FsyfTQj0oneZcajYI/CaH4IDss+xe/0O1zsqQ==
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
 AQHaA9HvmHelxVzMEkK9DIiJvUqDjbBW5OUAgAC5UoD//8WsgIAB4oYA//+CG4CAAI+hgIAAjVeAgAJwQAD//5FqAAAzXyGADyowGYD//4AlgIAAia6A//+C6oCAAItHgP//hKUAgAUWT4D//31GAAAQ5xwAABBKiAAAD6fOAAAuOxQAAEuTxoAApzqngAE9jPcA
Date: Mon, 15 Jan 2024 09:40:12 +0000
Message-ID:
 <BL1PR12MB58496E8AA1278A8E3573CCB7E76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20231021035111.650248-1-Jiqian.Chen@amd.com>
 <PH0PR12MB5481AD6A2E262A419FA2CBA8DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584943FA1C20BBF618EBB73AE76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481BB80679107D8E0167954DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584952204D1C8AD579F8A87CE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB548102E41B13AAB57C7321FCDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB5849F3E85F2661EB38128A67E76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481158BD79A17E1C49ACB6BDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB5849D8D396D00919482CB6D2E76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB548145B7409F2D58AC2F6D44DC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB58497CDB1A3AE937CAF24BCFE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB54816CC7AEE14209D3ECF795DC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To:
 <PH0PR12MB54816CC7AEE14209D3ECF795DC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|LV8PR12MB9083:EE_
x-ms-office365-filtering-correlation-id: 8bbbada9-f4a7-424f-f0ce-08dc15adf8bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 j40fG2W1r5dU/8JS6V7lJQQB2UNmj8keUk1cWJqIExrfcARWK3Ed8O8KEhJK3lIr/zZSNsBcK8CD6IiAk7vhz0vgGEvwuSJsrHU2ObcpRaERDNAdxAagYoZT4KUVgTwp92QW0+NhrN8E1+T445WyV2Q3F+vUCq4xlNoET9IHjPufOYy5f1HAnflyh6oXQ9wWyuWdXfo6mp6QwH8bMOJkd3TNCjEK0AhBWjeqAhixcDTXhh3+bSPHmaSHfQs8BN3VogYt+jD8o3uFIQB7MPkZJYqla42WBnSSsxIDTQd34FSp9L8fqKjeHkORLeqhemjUbQ3HJ1/vLanDXBOHf7fAz2dUXTJslTPN8ZmiNHgF3dtsvFP/bfkFl+XX2485TBZrbX2kg3/0ZCHkzqw2jU5CpYv/E+RKg3dpPLGSl4AiR1oWQIlT3KPLtyUucmmGpUFH598Hgrz/ugYlI0WyEVdFEqXqRzd6gwSHZRZj5o7YyhVMVsQ6ruK+mzG5l0jR6/ybLYO5+U+XkY9mBlKPgdCGd7v8Rhet5IHuw+e+FT/P+mwa0UXMK8YprOG4ooFjOPg7ET0gZl4CRwR+vtKzZwR7UNJQrNHd3JllDp0ys5o43tqGH+EuZVz4f94GIB8n0zaw
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(55016003)(66899024)(83380400001)(66476007)(122000001)(41300700001)(66556008)(66946007)(76116006)(316002)(38070700009)(7416002)(38100700002)(5660300002)(9686003)(7696005)(53546011)(478600001)(26005)(52536014)(64756008)(71200400001)(6916009)(2906002)(66446008)(8676002)(54906003)(4326008)(33656002)(6506007)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S0MvbVo2VHpmaFp0aThVK1orZGd1TW9KNTBkZXdsSEE4ME9MbEQ5QURhbjdR?=
 =?utf-8?B?ZG5uRW9oTUYrNDIrMkRxWk1ON1NBZEVkcnhxZmdCWDBLd0hTOTRLRGFvcndD?=
 =?utf-8?B?ejEyRHBBVnZGVm9kOVdWK3ROWWxWVzNQVWlqOS9kdXN0dnR2ei9QRk82cnpo?=
 =?utf-8?B?RVdLdml1WmFiU0duWUx3dVIxK3hpQllQamNwbXpHbm5WcmQwcmhiaEk0bWVv?=
 =?utf-8?B?UTk0UHM4amYvcDFYVzBURCt6eG1PRDJpNENHWk5Gb0N3cUVzU3pxV2J4U05U?=
 =?utf-8?B?UkpSNzltNWNXTFcyUlI3YjdRL0E3cVpBRWh5SFF2dVlyVGJHSHpKc01WWHpM?=
 =?utf-8?B?U20zTDdnTGphQnBkTU9lU1dST0tnUmpHSHpCcFdiMW8vaGMydmhKYitQby9o?=
 =?utf-8?B?eWhNK1B1RUxacWRDSTdOcEtLNldJeWNaZlQ5eUFYb2VqOFBmc2Z3bjQ0YmZH?=
 =?utf-8?B?c05rb0RTbXI0RzIvNlc2UlFYZUFaS1Vaano1YjdqYTYxWU5Ga1V1d1VhNENu?=
 =?utf-8?B?cUVveXN6V3hFdFh5TGNidndNUEpyUW94eTVuSnloWVY1L0c4Yng0Zm9ZMlcy?=
 =?utf-8?B?ZURoVHByRmpPYWdqek5NWUU2dndVSDR5NEdPSjdjNWpzRkcycXRGNVg1eDF4?=
 =?utf-8?B?M3lqV1B3cExqNFlISlVuTVNQTXJaSW5sb0RvM1Q3eTlrYXVRZXhwdi9XOTdj?=
 =?utf-8?B?VTRBZ3MrSUltbEJONWsyak5rQm52YVdqb3Y0Z2hYVXhMVG5PN2FvVXFDY2xZ?=
 =?utf-8?B?ZmpMMnptc0d2WjgwKzE3QjBhd3BFSkdsVXd0aGVQVmoxVG1GS0k1VGQ1Rksv?=
 =?utf-8?B?TThBU3grZ0NuZ2IzbDA3Y3JPRzZWVjUyVGRzZ05SbFV3Y0xLRzBNemJjbXVp?=
 =?utf-8?B?aTJaVTNHQ3diRGVFVEpwQ0pJUmY0eFpWdEg4blZ1R0RuQ1JHZzFEMkNIRGFB?=
 =?utf-8?B?ZWpqLzdDMUpBUFUzb3piYVhqSEVNODZuMkQyZittMDNaSTdrWmdtcVQxVmxl?=
 =?utf-8?B?dVBwNUphdWs0OHFadzVEU25NZUc0a012NWk1cUFhMVI0MnZXSWg0eXVOVzVG?=
 =?utf-8?B?SzZjQzR0RjQwdmx6NlIvM1V0YkdHZ2dlM1RnY1M4R0lmQ2FoSkpHZ1NaTHVH?=
 =?utf-8?B?Y1dZNExaK2E0N0lYL1puTWx3NklKZlVETGNVOWt4M3NkTVRVREtsZlNwQ0k2?=
 =?utf-8?B?NTg2R3JwdnlsUHlETnNMNkNqNzYwdmdocGtoYUpGNXl2ejh5ODFZbVFLVm9V?=
 =?utf-8?B?eHZEaFZ3enFLYWZ3aW94Z1NVZlNTYnMxV0IwNG1TMGl5YjBCL3hNbHF2RmVO?=
 =?utf-8?B?UHhzcHk3eXZlUkdOdlJ6bnB5YXMrNmhaSFNPUStvOFpOVzZ4eVRTb1NlcGxI?=
 =?utf-8?B?YlErMmQyR0R2eTZXTk1qMXpVbUgxQmxOVjFWNEhKL0RzSDVzNG5nYUw5TnNo?=
 =?utf-8?B?OWxKKzVHWG5XbmtKSjF5NVpqK0VGa0VDcXV0QlpDU1Mzd2xXdDNLeDhXdjNT?=
 =?utf-8?B?YmczZEVRSmRDQVNZd1Q5YUpieThUQSt0TGNrZHFaNHJtaVpKaUdaM2tPY0Zk?=
 =?utf-8?B?aUd2NFdnSTV2d0hibllTTUJtcVUrVE1ZbldQQmE1WVprUGNEYXZLb0l6N0V5?=
 =?utf-8?B?OHk3VVNmMVJLMVlOVzhFYWpzbUduazNJQ2x3S2Q4ZVVCZFdDK2xDOFdmZnc3?=
 =?utf-8?B?NHQxQVdZbitQb0p5UUxXcGozZDhrU3RhUzFobEFrRU5CTzZ4YnY2ZEdPbXhE?=
 =?utf-8?B?SWpaTFF2cVlRcHowakRiY2hXYkpYWW5kVFJ1UTgvNEVLUmo0TnlPcVB3OVNq?=
 =?utf-8?B?NFBHUXlOYnhDcEMzYk9lSWlrd0hzcWR4Nmp4NUtFV1NVVHRaeTNZRkIzQ0Ir?=
 =?utf-8?B?K25xTks4ZFlFQVh0d3ErZDZ4Zy9pUVRCc1pkSjdSNlkzZlhHRXlKTGg2MVk3?=
 =?utf-8?B?STg5QzUwdzRXQTVzemVTZUttcUE0ZWpwaFpYYlllZTh0N3BWZDRIMEdINU8w?=
 =?utf-8?B?ZW1HTkFHbWFuTE9jZGFwWCtaRXJ6UEtvQ1N1T0hHL1hGTXFwYzlNNGNYckpz?=
 =?utf-8?B?NVJ3aEZNd2IzVHFtb0I1dCt5Z2pHZFUwSUhETm45dUI5MFlWZk93V3BmV2Jz?=
 =?utf-8?Q?fKHo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFDBA46756D4A747A85379698CA079A6@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbbada9-f4a7-424f-f0ce-08dc15adf8bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 09:40:12.6273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q8OPNps8N2LrnxHIcPEwPxFBTSb9Z6FGoYDBnsNEK7s78m6Flkl68v9uaAFGCFXbt21FCn1fSHMXibxXzb90mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9083
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES

T24gMjAyNC8xLzE1IDE3OjE2LCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+IA0KPj4gRnJvbTogQ2hl
biwgSmlxaWFuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KPj4gU2VudDogTW9uZGF5LCBKYW51YXJ5
IDE1LCAyMDI0IDI6NDAgUE0NCj4+DQo+PiBPbiAyMDI0LzEvMTUgMTY6NTIsIFBhcmF2IFBhbmRp
dCB3cm90ZToNCj4+Pg0KPj4+PiBGcm9tOiBDaGVuLCBKaXFpYW4gPEppcWlhbi5DaGVuQGFtZC5j
b20+DQo+Pj4+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAxNSwgMjAyNCAxOjUxIFBNDQo+Pj4+DQo+
Pj4+IE9uIDIwMjQvMS8xNSAxNTo1NSwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPj4+Pj4NCj4+Pj4+
PiBGcm9tOiBDaGVuLCBKaXFpYW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+Pj4+Pj4gU2VudDog
TW9uZGF5LCBKYW51YXJ5IDE1LCAyMDI0IDE6MTggUE0NCj4+Pj4+Pg0KPj4+Pj4+IE9uIDIwMjQv
MS8xNSAxNTozNywgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPj4+Pj4+Pg0KPj4+Pj4+Pj4gRnJvbTog
Q2hlbiwgSmlxaWFuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KPj4+Pj4+Pj4gU2VudDogTW9uZGF5
LCBKYW51YXJ5IDE1LCAyMDI0IDE6MDMgUE0NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBPbiAyMDI0LzEv
MTIgMTc6NDQsIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+DQo+Pj4+
Pj4+Pj4+IEZyb206IENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4+Pj4+Pj4+
Pj4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDEyLCAyMDI0IDI6NTUgUE0NCj4+Pj4+Pj4+Pj4NCj4+
Pj4+Pj4+Pj4gT24gMjAyNC8xLzEyIDE2OjQ3LCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+Pj4+Pj4+
Pj4+Pg0KPj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+PiBGcm9tOiBDaGVuLCBKaXFpYW4gPEppcWlh
bi5DaGVuQGFtZC5jb20+DQo+Pj4+Pj4+Pj4+Pj4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDEyLCAy
MDI0IDE6NTUgUE0NCj4+Pj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+Pj4gT24g
MjAyNC8xLzEyIDE2OjAyLCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+Pj4+Pj4+Pj4+Pj4+IEhpIEpp
cWlhbiwNCj4+Pj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+Pj4+IEZyb206IENoZW4sIEppcWlhbiA8
SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4+Pj4+Pj4+Pj4+Pj4+IFNlbnQ6IEZyaWRheSwgSmFudWFy
eSAxMiwgMjAyNCAxOjExIFBNDQo+Pj4+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+Pj4+Pg0KPj4+Pj4+
Pj4+Pj4+Pj4gSGkgYWxsLA0KPj4+Pj4+Pj4+Pj4+Pj4gU29ycnkgdG8gcmVwbHkgbGF0ZS4NCj4+
Pj4+Pj4+Pj4+Pj4+IEkgZG9uJ3Qga25vdyBpZiB5b3Ugc3RpbGwgcmVtZW1iZXIgdGhpcyBwcm9i
bGVtLCBsZXQgbWUNCj4+Pj4+Pj4+Pj4+Pj4+IGJyaWVmbHkgZGVzY3JpcHQNCj4+Pj4+Pj4+Pj4g
aXQuDQo+Pj4+Pj4+Pj4+Pj4+PiBJIGFtIHdvcmtpbmcgdG8gaW1wbGVtZW50IHZpcnRncHUgUzMg
ZnVuY3Rpb24gb24gWGVuLg0KPj4+Pj4+Pj4+Pj4+Pj4gQ3VycmVudGx5IG9uIFhlbiwgaWYgd2Ug
c3RhcnQgYSBndWVzdCB0aHJvdWdoIHFlbXUgd2l0aA0KPj4+Pj4+Pj4+Pj4+Pj4gZW5hYmxpbmcg
dmlydGdwdSwgYW5kIHRoZW4gc3VzcGVuZCBhbmQgcmVzdW1lIGd1ZXN0LiBXZSBjYW4NCj4+Pj4+
Pj4+Pj4+Pj4+IGZpbmQgdGhhdCB0aGUgZ3Vlc3Qga2VybmVsIGNvbWVzIGJhY2ssIGJ1dCB0aGUg
ZGlzcGxheSBkb2Vzbid0Lg0KPj4+Pj4+Pj4+Pj4+Pj4gSXQganVzdCBzaG93biBhIGJsYWNrDQo+
Pj4+Pj4+Pj4+Pj4gc2NyZWVuLg0KPj4+Pj4+Pj4+Pj4+Pj4gVGhhdCBpcyBiZWNhdXNlIGR1cmlu
ZyBzdXNwZW5kaW5nLCBndWVzdCBjYWxsZWQgaW50byBxZW11DQo+Pj4+Pj4+Pj4+Pj4+PiBhbmQg
cWVtdSBkZXN0cm95ZWQgYWxsIGRpc3BsYXkgcmVzb3VyY2VzIGFuZCByZXNldA0KPj4+Pj4+Pj4+
Pj4+Pj4gcmVuZGVyZXIuIFRoaXMgbWFkZSB0aGUgZGlzcGxheSBnb25lIGFmdGVyIGd1ZXN0IHJl
c3VtZWQuDQo+Pj4+Pj4+Pj4+Pj4+PiBTbywgSSBhZGQgYSBuZXcgY29tbWFuZCBmb3IgdmlydGlv
LWdwdSB0aGF0IHdoZW4gZ3Vlc3QgaXMNCj4+Pj4+Pj4+Pj4+Pj4+IHN1c3BlbmRpbmcsIGl0IHdp
bGwgbm90aWZ5IHFlbXUgYW5kIHNldA0KPj4+Pj4+Pj4+Pj4+Pj4gcGFyYW1ldGVyKHByZXNlcnZl
cl9yZXNvdXJjZSkgdG8gMSBhbmQgdGhlbiBxZW11IHdpbGwNCj4+Pj4+Pj4+Pj4+Pj4+IHByZXNl
cnZlIHJlc291cmNlcywgYW5kIHdoZW4gcmVzdW1pbmcsIGd1ZXN0IHdpbGwgbm90aWZ5DQo+Pj4+
Pj4+Pj4+Pj4+PiBxZW11IHRvIHNldCBwYXJhbWV0ZXIgdG8gMCwgYW5kIHRoZW4gcWVtdSB3aWxs
IGtlZXAgdGhlDQo+Pj4+Pj4+Pj4+Pj4+PiBub3JtYWwNCj4+Pj4gYWN0aW9ucy4NCj4+Pj4+Pj4+
Pj4+Pj4+IFRoYXQgY2FuDQo+Pj4+Pj4+Pj4+IGhlbHAgZ3Vlc3QncyBkaXNwbGF5IGNvbWUgYmFj
ay4NCj4+Pj4+Pj4+Pj4+Pj4+IFdoZW4gSSB1cHN0cmVhbSBhYm92ZSBpbXBsZW1lbnRhdGlvbiwg
UGFyYXYgYW5kIE1TVA0KPj4gc3VnZ2VzdA0KPj4+Pj4+Pj4+Pj4+Pj4gbWUNCj4+Pj4+Pj4+IHRv
DQo+Pj4+Pj4+Pj4+Pj4gdXNlDQo+Pj4+Pj4+Pj4+Pj4+PiB0aGUgUE0gY2FwYWJpbGl0eSB0byBm
aXggdGhpcyBwcm9ibGVtIGluc3RlYWQgb2YgYWRkaW5nIGENCj4+Pj4+Pj4+Pj4+Pj4+IG5ldyBj
b21tYW5kIG9yIHN0YXRlIGJpdC4NCj4+Pj4+Pj4+Pj4+Pj4+IE5vdywgSSBoYXZlIHRyaWVkIHRo
ZSBQTSBjYXBhYmlsaXR5IG9mIHZpcnRpby1ncHUsIGl0IGNhbid0DQo+Pj4+Pj4+Pj4+Pj4+PiBi
ZSB1c2VkIHRvIHNvbHZlIHRoaXMgcHJvYmxlbS4NCj4+Pj4+Pj4+Pj4+Pj4+IFRoZSByZWFzb24g
aXM6DQo+Pj4+Pj4+Pj4+Pj4+PiBkdXJpbmcgZ3Vlc3Qgc3VzcGVuZGluZywgaXQgd2lsbCB3cml0
ZSBEMyBzdGF0ZSB0aHJvdWdoIFBNDQo+Pj4+Pj4+Pj4+Pj4+PiBjYXAsIHRoZW4gSSBjYW4gc2F2
ZSB0aGUgcmVzb3VyY2VzIG9mIHZpcnRpby1ncHUgb24gUWVtdQ0KPj4+Pj4+Pj4+Pj4+Pj4gc2lk
ZShzZXQgcHJlc2VydmVyX3Jlc291cmNlIHRvIDEpLCBidXQgZHVyaW5nIHRoZSBwcm9jZXNzDQo+
Pj4+Pj4+Pj4+Pj4+PiBvZiByZXN1bWluZywgdGhlIHN0YXRlIG9mIFBNIGNhcCB3aWxsIGJlIGNs
ZWFyZWQgYnkgcWVtdQ0KPj4+Pj4+Pj4+Pj4+Pj4gcmVzZXR0aW5nKHFlbXVfc3lzdGVtX3dha2V1
cC0+IHFlbXVfZGV2aWNlc19yZXNldC0+DQo+Pj4+Pj4+Pj4+Pj4+PiB2aXJ0aW9fdmdhX2Jhc2Vf
cmVzZXQtPiB2aXJ0aW9fZ3B1X2dsX3Jlc2V0KSwgaXQgY2F1c2VzDQo+Pj4+Pj4+Pj4+Pj4+PiB0
aGF0IHdoZW4gZ3Vlc3QgcmVhZHMgc3RhdGUgZnJvbSBQTSBjYXAsIGl0IHdpbGwgZmluZCB0aGUN
Cj4+Pj4+Pj4+Pj4+Pj4+IHZpcnRpby1ncHUgaGFzIGFscmVhZHkgYmVlbiBEMCBzdGF0ZSwNCj4+
Pj4+Pj4+Pj4+Pj4gVGhpcyBiZWhhdmlvciBuZWVkcyB0byBiZSBmaXhlZC4gQXMgdGhlIHNwZWMg
bGlzdGVkIG91dCwgIg0KPj4+Pj4+Pj4+Pj4+PiBUaGlzIDItYml0IGZpZWxkIGlzDQo+Pj4+Pj4+
Pj4+Pj4gdXNlZCBib3RoIHRvIGRldGVybWluZSB0aGUgY3VycmVudCBwb3dlciBzdGF0ZSBvZiBh
IEZ1bmN0aW9uIg0KPj4+Pj4+Pj4+Pj4+IERvIHlvdSBtZWFuIGl0IGlzIHdyb25nIHRvIHJlc2V0
IFBNIGNhcCB3aGVuIHZyaXRpb19ncHUgcmVzZXQNCj4+Pj4+Pj4+Pj4+PiBpbiBjdXJyZW50IHFl
bXUgY29kZT8gV2h5Pw0KPj4+Pj4+Pj4+Pj4gQmVjYXVzZSBQTSBpcyBpbXBsZW1lbnRpbmcgdGhl
IHN1cHBvcnQgZnJvbSBEMy0+ZDAgdHJhbnNpdGlvbg0KPj4+Pj4+Pj4+Pj4gYW5kIGlmIGl0DQo+
Pj4+Pj4+Pj4+IGRldmljZSBpbiBEMywgdGhlIGRldmljZSBuZWVkcyB0byByZXNwb25kIHRoYXQg
aXQgaXMgaW4gRDMgdG8NCj4+Pj4+Pj4+Pj4gbWF0Y2ggdGhlIFBDSSBzcGVjLg0KPj4+Pj4+Pj4+
Pj4NCj4+Pj4+Pj4+Pj4+PiBTaG91bGRuJ3QgYWxsIGRldmljZSBzdGF0ZXMsIGluY2x1ZGluZyBQ
TSByZWdpc3RlcnMsIGJlIHJlc2V0DQo+Pj4+Pj4+Pj4+Pj4gZHVyaW5nIHRoZSBwcm9jZXNzIG9m
IHZpcnRpby1ncHUgcmVzZXQ/DQo+Pj4+Pj4+Pj4+PiBJZiBOb19Tb2Z0X1Jlc2V0PT0gMCwgbm8g
ZGV2aWNlIGNvbnRleHQgdG8gYmUgcHJlc2VydmVkLg0KPj4+Pj4+Pj4+Pj4gSWYgTm9fU29mdF9S
ZXNldCA9PSAxLCBkZXZpY2UgdG8gcHJlc2VydmUgbWluaW1hbCByZWdpc3RlcnMNCj4+Pj4+Pj4+
Pj4+IGFuZCBvdGhlcg0KPj4+Pj4+Pj4+PiB0aGluZ3MgbGlzdGVkIGluIHBjaSBzcGVjLg0KPj4+
Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+Pj4+PiBTbyBk
ZXZpY2UgbmVlZHMgdG8gcmV0dXJuIEQzIGluIHRoZSBQb3dlclN0YXRlIGZpZWxkLiAgVGhpcyBp
cw0KPj4gbXVzdC4NCj4+Pj4+Pj4+Pj4+PiBCdXQgY3VycmVudCBiZWhhdmlvciBpcyBhIGtpbmQg
b2Ygc29mdCByZXNldCwgSQ0KPj4+Pj4+Pj4+Pj4+IHRoaW5rKCFQQ0lfUE1fQ1RSTF9OT19TT0ZU
X1JFU0VUKS4gVGhlIHBtIGNhcCBpcyByZXNldCBieQ0KPj4+PiBxZW11DQo+Pj4+Pj4gaXMNCj4+
Pj4+Pj4+Pj4+PiByZWFzb25hYmxlLg0KPj4+Pj4+Pj4+Pj4gV2hhdCB5b3UgZGVzY3JpYmVkIGlz
LCB5b3UgbmVlZCB0byBkbyBOb19Tb2Z0X1Jlc2V0PTEsIHNvDQo+Pj4+Pj4+Pj4+PiBwbGVhc2Ug
c2V0IHRoZQ0KPj4+Pj4+Pj4+PiBjYXAgYWNjb3JkaW5nbHkgdG8gYWNoaWV2ZSB0aGUgcmVzdG9y
ZS4NCj4+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+PiBBbHNvIGluIHlvdXIgY2FzZSB0aGUgaWYgdGhl
IFFFTVUga25vd3MgdGhhdCBpdCB3aWxsIGhhdmUgdG8NCj4+Pj4+Pj4+Pj4+IHJlc3VtZSB0aGUN
Cj4+Pj4+Pj4+Pj4gZGV2aWNlIHNvb24uDQo+Pj4+Pj4+Pj4+PiBIZW5jZSwgaXQgY2FuIHdlbGwg
cHJlcGFyZSB0aGUgZ3B1IGNvbnRleHQgYmVmb3JlIHJlc3VtaW5nIHRoZQ0KPj4gdmNwdXMuDQo+
Pj4+Pj4+Pj4+PiBJbiBzdWNoIGNhc2UsIHRoZSBleHRyYSByZWdpc3RlciB3b3VsZG7igJl0IGJl
IG5lY2Vzc2FyeS4NCj4+Pj4+Pj4+Pj4+IEhhdmluZyBQTSBjb250cm9sIHJlZ2lzdGVyIGlzIGFu
eXdheSBuZWVkZWQgdG8gZHJpdmUgdGhlDQo+Pj4+Pj4+Pj4+PiBkZXZpY2UNCj4+Pj4+PiBwcm9w
ZXJseS4NCj4+Pj4+Pj4+Pj4gRXZlbiBhcyB5b3Ugc2FpZCwgdGhlIHJlc2V0IGJlaGF2aW9yIG9m
IFBNIGluIHRoZSBjdXJyZW50IFFFTVUNCj4+Pj4+Pj4+Pj4gY29kZSBpcyBpbmNvcnJlY3QsIGFu
ZCBldmVuIGlmIGl0IGlzIG1vZGlmaWVkLCBpdCBhbHNvIGNhbm5vdA0KPj4+Pj4+Pj4+PiBmaXgg
dGhpcyBwcm9ibGVtIHdpdGgNCj4+Pj4+PiBTMy4NCj4+Pj4+Pj4+PiBZb3UgbWVhbnQgRDM/DQo+
Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4gQmVjYXVzZSB0aGVyZSBpcyB0d2ljZSBkZXZpY2UgcmVzZXQg
ZHVyaW5nIHJlc3VtaW5nLg0KPj4+Pj4+Pj4+PiBGaXJzdCBpcyB3aGVuIHdlIHRyaWdnZXIgYSBy
ZXN1bWUgY29tbWFuZCB0byBxZW11LCBxZW11IHdpbGwNCj4+Pj4+Pj4+Pj4gcmVzZXQgZGV2aWNl
KHFlbXVfc3lzdGVtX3dha2V1cC0+IHFlbXVfZGV2aWNlc19yZXNldC0+DQo+Pj4+Pj4+Pj4+IHZp
cnRpb192Z2FfYmFzZV9yZXNldC0+IHZpcnRpb19ncHVfZ2xfcmVzZXQpLg0KPj4+Pj4+Pj4+IEEg
ZGV2aWNlIGltcGxlbWVudGF0aW9uIHRoYXQgc3VwcG9ydHMgUE0gc2hvdWxkIG5vdCByZXNldCB0
aGUNCj4+IGRldmljZS4NCj4+Pj4+Pj4+IFBsZWFzZSBmaXggaXQuDQo+Pj4+Pj4+PiBEbyB5b3Ug
bWVhbiB0aGUgZGV2aWNlc19yZXNldCBiZWhhdmlvciBvZiBxZW11IHNob3VsZG4ndCBoYXBwZW4N
Cj4+Pj4+Pj4+IHdoZW4gYSBkZXZpY2UgaGFzIFBNIGNhcD8NCj4+Pj4+Pj4gUmlnaHQuIERldmlj
ZSByZXNldCBzaG91bGQgbm90IGhhcHBlbiBvbiBQTSBjYXBhYmxlIGRldmljZSB0aGF0DQo+Pj4+
Pj4+IG9mZmVycw0KPj4+Pj4+IG5vX3NvZnRfcmVzZXQ9PTEuDQo+Pj4+Pj4gQnV0IGN1cnJlbnQg
cWVtdSBjb2RlLCBub19zb2Z0X3Jlc2V0PT0wLg0KPj4+Pj4+DQo+Pj4+PiBTbyBwbGVhc2UgZml4
IHRoZSBxZW11IHdoZW4geW91IGFyZSBhZGRpbmcgdGhlIGZ1bmN0aW9uYWxpdHkgb2YNCj4+Pj4+
IHJlc3RvcmluZw0KPj4+PiB0aGUgZGV2aWNlIGNvbnRleHQgb24gUE0uDQo+Pj4+IE15IHBhdGNo
IGRpZG4ndCBhZGQgdGhlIGZ1bmN0aW9uYWxpdHkgb2YgcmVzdG9yaW5nIHRoZSBkZXZpY2UgY29u
dGV4dCBvbg0KPj4gUE0uDQo+Pj4+IElzIG5vX3NvZnRfcmVzZXQgbXVzdCBzZXQgMSB3aGVuIGEg
ZGV2aWNlIGhhcyBQTSBjYXA/DQo+Pj4NCj4+PiBJdCB0aGUgZGV2aWNlIHdhbnRzIHRvIGV4cG9z
ZSB0aGUgYWJpbGl0eSB0byBzYXZlIGFuZCByZXN0b3JlIGNvbnRleHQsIHRoZW4NCj4+IHllcywg
bm9fc29mdF9yZXNldCA9IDEsIGFzIGRlZmluZWQgYnkgdGhlIFBDSSBzcGVjLg0KPj4+DQo+Pj4+
IEl0IHNob3VsZCBhbHNvIGJlDQo+Pj4+IGFsbG93ZWQgZm9yIHNpdHVhdGlvbnMgdGhhdCBhcmUg
bm90IGVxdWFsIHRvIDEsIHJpZ2h0Pw0KPj4+IEkgZG9u4oCZdCBzZWUgdGhlIG5lZWQgb2YgaXQu
IEl0IHdvdWxkIG5vdCBiZSBhbGlnbmVkIHRvIG5vX3NvZnRfcmVzZXQgYml0IGFscmVhZHkNCj4+
IGRlZmluZWQgYml0Lg0KPj4+DQo+Pj4+IFRoZXJlIHNob3VsZCBiZSBkZXZpY2VzIHRoYXQgaGFz
IFBNIGNhcCBidXQgbm9fc29mdF9yZXNldCBpcyAwDQo+Pj4+IGJlY2F1c2UgdGhhdCBkZXZpY2Vz
IGNhbid0IHN0b3JlIGFuZCByZXN0b3JlIHRoZSBkZXZpY2UgY29udGV4dCBvbg0KPj4+PiBkMy0+
ZDAgdHJhbnNpdGlvbiwgbGlrZSBjdXJyZW50IHFlbXUgY29kZS4NCj4+PiBSaWdodCwgUE0gY2Fw
IHdpdGggbm9fc29mdF9yZXNldD0wLCB3aWxsIG5vdCByZXN0b3JlIHRoZSBjb250ZXh0IG9uIGQz
LT5kMA0KPj4gYXMgdG9kYXkuDQo+Pj4NCj4+Pj4gU28gdGhlIGZpeCBzaG91bGQgYmUgZmVhc2li
bGUgZm9yIGFsbCBzaXR1YXRpb25zIHRoYXQgd2hldGhlciB0aGUNCj4+Pj4gbm9fc29mdF9yZXNl
dCBpcw0KPj4+PiAxIG9yIG5vdC4NCj4+PiBJIGRvbuKAmXQgZm9sbG93IHRoZSAiZml4IHNob3Vs
ZCBiZSBmZWFzaWJsZSIuDQo+PiBJIG1lYW4gdGhlIGZpeCB0aGF0IHRvIHNvbHZlIHRoZSBwcm9i
bGVtKHZpcnRpby1ncHUncyBkaXNwbGF5IHJlc291cmNlcyBhcmUNCj4+IGRlc3Ryb3llZCBkdXJp
bmcgUzMpIHNob3VsZCBhbHNvIGJlIGZlYXNpYmxlIHRvIHRoZSBzaXR1YXRpb24gdGhhdA0KPj4g
bm9fc29mdF9yZXNldCA9PSAwLg0KPj4NCj4+PiBRRU1VIHJlc2V0IHRoZSBkZXZpY2Ugb24gZDMt
PmQwIHRyYW5zaXRpb24gd2hlbiBub19zb2Z0X3Jlc2V0ID0gMCBzZWVtcw0KPj4gZmluZSBiZWNh
dXNlIGl0IGZvbGxvd3MgdGhlIGRlZmluZWQgcGNpIHNwZWMuDQo+PiBSaWdodC4NCj4+IE5vdyB0
aGF0IHlvdSBhbHNvIHRoaW5rIHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIG9mIFFFTVUgaXMg
cmVhc29uYWJsZSwNCj4+IHRoZSBmaXggdG8gdGhpcyBwcm9ibGVtKGRpc3BsYXkgcmVzb3VyY2Vz
IGFyZSBkZXN0cm95ZWQgZHVyaW5nIFMzKSBzaG91bGQgYmUNCj4+IGFwcGxpY2FibGUgdG8gdGhl
IGN1cnJlbnQgUUVNVSBjb2RlLg0KPiBZZXMuDQo+IA0KPiBUbyBjb25jbHVkZSBvdXIgZGlzY3Vz
c2lvbiwNCj4gDQo+IERpc3BsYXkgcmVzb3VyY2VzIHNob3VsZCBiZSBvbmx5IHJlc3RvcmVkIHdo
ZW4gZm9sbG93aW5nIGNvbmRpdGlvbnMgYXJlIG1ldC4NCj4gMS4gUENJIFBNIGNhcCBpcyByZXBv
cnRlZC4NCj4gMi4gUENJIFBNIGNhcCBoYXMgbm9uX3NvZnRfcmVzZXQ9MQ0KPiAzLiB2aXJ0aW8g
Z3Vlc3QgZHJpdmVyIGRvIG5vdCBwZXJmb3JtIHJlc2V0IHdoZW4gdHJhbnNwb3J0IG9mZmVycyBh
IHJlc3RvcmUgY2FwYWJpbGl0eSB1c2luZyAjMSBhbmQgIzIuDQo+IA0KPiBEbyB5b3UgYWdyZWU/
IFllcz8NClllcywgSSB0aGluayB0aGlzIHByb2JsZW0gKGRpc3BsYXkgcmVzb3VyY2VzIGFyZSBk
ZXN0cm95ZWQgZHVyaW5nIFMzKSBjYW4gYmUgc29ydGVkIHRvIHR3byBzaXR1YXRpb25zOg0KRmly
c3QgaXMgd2hhdCB5b3Ugc2FpZCBhYm92ZSwgaW4gdGhpcyBzaXR1YXRpb24sIHRoZSBkZXZpY2Vz
X3Jlc2V0IG9mIHFlbXUgaXMgdW5yZWFzb25hYmxlLCBpZiBhIGRldmljZSBoYXMgUE0gY2FwIGFu
ZCBub25fc29mdF9yZXNldD0xLCBxZW11IHNob3VsZCBub3QgZG8gcmVzZXR0aW5nLg0KU2Vjb25k
IGlzIHdpdGhvdXQgIzEgb3IgIzIsIHRoZSByZXNldCBiZWhhdmlvciBpcyBmaW5lLiBNeSBwYXRj
aCBpcyB0byBmaXggdGhpcyBzaXR1YXRpb24sIHRoYXQgc2VuZGluZyBhIG5ldyB2aXJ0aW8tZ3B1
IGNvbW1hbmQgdG8gbm90aWZ5IHFlbXUgdG8gcHJldmVudCBkZXN0cm95aW5nIGRpc3BsYXkgcmVz
b3VyY2VzIGR1cmluZyBTMy4NCg0KPiANCj4+IElmIHVzaW5nIFBNIGNhcCwgaXQgY2Fubm90IHNv
bHZlIHRoZSBwcm9ibGVtIGVuY291bnRlcmVkIGluIGN1cnJlbnQgUUVNVQ0KPj4gY29kZS4NCj4+
IEkgdGhpbmsgeW91IG1heSBub3QgaGF2ZSBoYWQgYSBkZXRhaWxlZCB1bmRlcnN0YW5kaW5nIG9m
IG15IG1vZGlmaWNhdGlvbnMuIEkNCj4+IHdpbGwgcmVzZW5kIHRoZSBsYXRlc3QgbW9kaWZpY2F0
aW9ucyBvbiB0aGUgTGludXgga2VybmVsIGFuZCBRRU1VIHRvDQo+PiB1cHN0cmVhbS4NCj4+IFdl
bGNvbWUgdG8gcmV2aWV3Lg0KDQotLSANCkJlc3QgcmVnYXJkcywNCkppcWlhbiBDaGVuLg0K

