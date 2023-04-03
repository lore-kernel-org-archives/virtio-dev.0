Return-Path: <virtio-dev-return-11910-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6085C76196
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:48:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1595A6040C
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:48:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0845C98658A
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:48:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F30B59863DF; Mon,  3 Apr 2023 15:48:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E00349863DE;
	Mon,  3 Apr 2023 15:47:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9Y87Z2UzN2GiNekPLQdOxM7GLg4C5T+1JVjaQ8SJdFyBALJbrPbk6B/so1aAeRJKlr2BBuRSiUMKGyFO8YXFqQ1tHv8bI07rZoAfeAcbYMgiWCJ1A/72TklsSNw0N7CbSFv5BCJ54DZN252b9RvdGY9HVew56ty1aWfruWzz6xpJzBnW8iXMBOBNrUo3U4H5q+EfT4w6cUYtc1WBKHwUGDUqA6p1zqkWiFpgWZDzsDceSnr0K9NZlCes5iGOq1+uMB/R4o+zBT4NOap98gk58DqLYGHqM4BCmGIB2equuPQSU4uJ2agZl8Vnj+Z+VhjaQDptU68R5iaJPr7W+brkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkZhuhiscxNzWHYveCSX/Dl8elPTV3xxf3x+XB9nTBE=;
 b=BgnWJvBMtZ/XG8zDG+XVGose3YIky2to1gkSKQgrE8FT4DXiM3xKBfJw740bcNIsZIxA2qa5lLVDRVIq2F3V/+v3vfs39Mqva2uscJQG96Haz7yqB0xfn0yUFBFatmw+XIUKB9ymPQSvEo+XKjQl8vS6TdOPVuN5R4RERvw9Zuccm/d+yRMppNuOl8gZRJDF4CMEtqkiGvyVbsEH494goSubDlbrNsdbjmTwjcKKO9Z4pwcgTqoLKqEkhg9u4MWa3TxpTSzlpY2fhc73wVacEnvUveo969mVtwKs0NmbAMlMpHNhCvUeTYJxffl1JjXeImTbXrXnJj/Vp2XUkfahIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH 00/11] Introduce transitional mmr pci device
Thread-Index: AQHZZkHJUKpXI6BlJ02o18szYVzlVK8ZuS7Q
Date: Mon, 3 Apr 2023 15:47:56 +0000
Message-ID:
 <PH0PR12MB54815BFAFF4BC17F37864B8FDC929@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230331024500-mutt-send-email-mst@kernel.org>
 <0dcd9907-4bb0-ef0d-678d-5bc8f0ded9ec@nvidia.com>
 <20230403105050-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D50080A3A7C5F81E3F62DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403110320-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EC65708410304D9C1EA3DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403111735-mutt-send-email-mst@kernel.org>
 <20230403113130-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230403113130-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB7180:EE_
x-ms-office365-filtering-correlation-id: 9f393f8d-67d0-40e3-35a7-08db345acb54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ohGHWC5v+BcFa7Fggtft/XbXKPd6gks/0U0+wrDl7OAWd0d8dR8y7ZKzuh2nDfItMubZqvYHO4aBUy3rLCEgV/HP6cJHaqUliWXgqzSnUdB1IMAg6215VGfGHsnRZ6xOmutrQt9zhcJLVsj7Z6aNKLmlhUqCLXHdjreTaW13tdJ0tUNnpVdPVxhnpnBUJ+aSSDS/9xb5rFYJsaY6ha3FuXweHhT7aLqjnpBOORFW/sFaFDnhs8pbX69s5+JJuEloE+i6UhIbj+aeVZb9ulebsjgr5S6QSLGWr/rw1PBJOZ7SAlakUIH+4TmMuTrS66PRjfGIsV3BOjvKz9RUpHIyCT1AKF31bqfhnLjcWvtpblcLFxxW6DbzvuB693oJh5dVDCTnVlBJy2ztrDYYdZJdDywlQybh2pcvbuFZPfDXDwSKPBi7b7N62WM7wBLlgi+k0lqmqyCnpHjVT6hZScL/XS7NGppsCt61pApXp3zXzvhoVnZr7OHJ4GgK6FOW1pxATSYekSqIk2Kc4X9FMq5M08eFkVbXuwmMMxd3MS+4NPxBuBpTc2BYPlx2i7MNjRfrr5H1wzln+1H1VTrSOAdP+EWEIH5SGUhsFRv3+ubYC+IacGZa4FMI/PH7W7c8ZKWa
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199021)(55016003)(6916009)(4326008)(76116006)(8676002)(66946007)(66476007)(64756008)(66556008)(478600001)(66446008)(54906003)(316002)(8936002)(52536014)(4744005)(5660300002)(122000001)(41300700001)(38100700002)(186003)(7696005)(71200400001)(107886003)(9686003)(6506007)(86362001)(33656002)(2906002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uIgDUjfy4Iz6oPUXf/vRoPvDtwZXZTtUprWJfLx85iNElCa3H1PhypPmP9dN?=
 =?us-ascii?Q?vu8akuiibAtdlddNIoeE6jhvFcCgrIKaBc5h1nuXxcTe57OqMSHaye7Rkg+M?=
 =?us-ascii?Q?c/C0UeD830TCzNZdGPQQ4rA5w1B92tCGyOLTWZ+vpmrZOU/VropF3JJFD9nb?=
 =?us-ascii?Q?8oFmCWYGHkFyeijli6W9zGh3yv0kjH8Ip+pyT6p2iv4A2JRH5H20hUaJpBYx?=
 =?us-ascii?Q?P//cK2V+Nu66Z1rzYeGlvKDRaKHYwN0Og35rQgX/30or2l8u6X6kgQ5hzA+T?=
 =?us-ascii?Q?QVnRTaLGqJsWdw/k5f0OR2cP9Q/+y2BQKpZOATG2KV/sw0ADCCKVE53UT5GW?=
 =?us-ascii?Q?XC3FLqvMdRfbvvNYjmZXzKVQ/CwVuBJ5jM0uLINYmjU9CQ6DaBA2IG3LNsv7?=
 =?us-ascii?Q?1V4lcktd9eGPrVgldS8eC8CbnGMffeenqPu4Pw1J5NeG1ExKlMMEo0taH4pI?=
 =?us-ascii?Q?s+jZMM/aS2vwlOU+vR8zYCDfIh/FdslIaKojhjkrZ+Mz5woNQhPewZuM2oHl?=
 =?us-ascii?Q?WPM0G8hB48l/iMo/QcFswElrjyPFznDATYd2YN3KC84Qxw5PSytI88WSE02d?=
 =?us-ascii?Q?hIPfKJQL9/U33k9xprCnMe0y5ij2X4W4Z8/JykkBu1cxOcJbUmIXP/0Bkk5K?=
 =?us-ascii?Q?DtWaSmM1GOSCJbd8apAt8N2m83P1ZZ18WwIC+OYxs2xreNI3j9Itu0nTNrvk?=
 =?us-ascii?Q?pWDbcBpdaKdxhaR5KXiLdnr5QYJKhLoUocjsIJUI3WUD+Pyz5U9/kBH0sm+j?=
 =?us-ascii?Q?0pNuQhNPEWAb+Dzntq6j0+CdVElcpZ0sg0CtGlOZOEdglXhxRTxDVdaIiDTH?=
 =?us-ascii?Q?VdtRD0/4rd7/+Xd/NUD/JpCZC34HNapgDcSPLvIijbTzybwZ104RvRBqQ4uC?=
 =?us-ascii?Q?vr1yH3LP6CQAa39vV99vcwqUUgMKRkUtT7vQsUL4Hvc9ac4JMpD2/fsaL5x8?=
 =?us-ascii?Q?fmVeuxG2ZiUTuKf5FUHg4sH6jZmqHZGBUdqqyete+AAEZyvMYf0HbE/+vAF8?=
 =?us-ascii?Q?uRcsm1wC8WveWedvWFCB0mh8ZRcq9xWG6G+AGyeSiBmAnXzpLHW5DLtpVrmG?=
 =?us-ascii?Q?CJbmG+zpWE7DILz+TPjXLhFOMSRUDb7+F3YyuC4nDwr4FNJdEoA5hnVImM7V?=
 =?us-ascii?Q?JRk7OX2l9J/mCdAe12AWpXVq/EfPiTd7IQC4LZy1ivEpMVBIXm3FF24uZVmo?=
 =?us-ascii?Q?40Hv+62oqY8DloiVKz/4DDbwVoEHnpQELfeS9fsUiyRRrOFsIbO50Uoavbws?=
 =?us-ascii?Q?2VT7cRKinlNUCr+K7TOTmcKuy4L6XT+8qD2Hx0+NBV8b1WKjwGeshBC06Ve1?=
 =?us-ascii?Q?aa6QyMsFy2u0uz2QlyMxcn+w4lmyTOzN/EEVIXEMTWwmaaO+BcuUzgHY/2DG?=
 =?us-ascii?Q?ILUYP8Pmxjvjn4WQiAvS/FoEc6eHwjIjPh5NJCEwEHjN0DYwxU9yHyNcKApn?=
 =?us-ascii?Q?HHvY7tGXIZ0Gu21CYpVG01l9X3PVMP00f2XJYwd+zWw+MsYzLMh4DRszxijs?=
 =?us-ascii?Q?/GB3vZHlOHb7Uiwa8DC7VEB85+kQEsaqcXyuf2i15hE27VZVBA+w/awtOhbf?=
 =?us-ascii?Q?mNhPGhqkVlQCPs5l4JCvQ8XtziMJpJPEXVj8jnMild3fn5qlckWG10GMM6tI?=
 =?us-ascii?Q?2K5aJS7nXZAWptPErvNnAkM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f393f8d-67d0-40e3-35a7-08db345acb54
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 15:47:56.5865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nUbrFBiwItNGnR2M7xN3hoBD+Of73uWrBON1sSFwZXlzkrBlvJF14lMJGX4UC4HxueNgATfoijl5lf/24rgqEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7180
Subject: [virtio-dev] RE: [PATCH 00/11] Introduce transitional mmr pci device



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, April 3, 2023 11:34 AM

> Another is that we can actually work around legacy bugs in the hypervisor=
. For
> example, atomicity and alignment bugs do not exist under DMA. Consider MA=
C
> field, writeable in legacy.  Problem this write is not atomic, so there i=
s a window
> where MAC is corrupted.  If you do MMIO then you just have to copy this b=
ug.
> If you do DMA then hypervisor can buffer all of MAC and send to device in=
 one
> go.
I am familiar with this bug.
Users feedback that we received so far has kernels with driver support that=
 uses CVQ for setting the mac address on legacy device.
So, it may help but not super important.

Also, if I recollect correctly, the mac address is configuring bit early in=
 if-scripts sequence before bringing up the interface.
So, haven't seen real issue around it.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

