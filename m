Return-Path: <virtio-dev-return-11720-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A152EC76195
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 17:03:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 045C34256A
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 17:03:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E49429864A5
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 17:03:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D822A98644E; Wed, 22 Mar 2023 17:03:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C3E5B986450;
	Wed, 22 Mar 2023 17:02:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmR9Z/i6BGuDxRWUz9Qlb4cJRaYoXTRsEtbkDuLxQ6rBirIU8nx5W54y1nqA1MURQH+PjfN28vuE5tgHRFdo9ZbmgukQK9URuWCjlWek3AUppgsyIFzQoiSDdlBv09cS3eHymmZzyvf2jVC4rMlnR+s9rMCWt2qu9R1C+Lgwlwh4hU34VeB6kunQkberSphkg3d/bIzy82FsfxFoBOz3TLsKVscxbGRNb537rtnVvEDbPiKyChxLlhHvAiaX7OiTuYHUgVirLtng5mZ8LlKycRoG72YU0KD4eGlVJSgQgWb9bp42MIos2m592KzVSGbIXjZYs4TCzcggUABXssy6Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aibe6kNuY+q7D4u9qUGiAR1bGTdoGQSPYcKo28qG0nk=;
 b=VbjJATli+MyIBcLHRUHLvmKIFjc60sMjPFbG16V3qQEg9zxhSCMSvnVI0j9tAx7mEwfmgRUokaNEtA8qZuKzxjKL/ERXFEbdMc5iHh3zgpoVqqLgXSkoKlMf6dPnt/4RMkMGp0zYrXqXTN+IcwanElSayyM7UEmWk0B4HiNXwovc7O/eNY/gmlvy6wRCqeV/n8Pv96zSkmOFuzX+SYJi00WfVcQdxr63ePoBAWanX+bYKcaMGIkqZhsBtcjtMMmFxbcLuT6kij9lzsUQKCRUb2Jsrs6K+QeWuTgyf6hGO+A7nKAEDmjI0C5l8c+OJA4igUPqxutxeyy1dfQI7s3Fuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Cornelia Huck <cohuck@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>,
	David Edmondson <david.edmondson@oracle.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-comment] RE: [PATCH v13] virtio-net: support the
 virtqueue coalescing moderation
Thread-Index:
 AQHZXL0YQHWs+6YDyUK7u3Kjjs+HRK8G6jaAgAAQ9sCAAARNgIAAACrQgAACBICAAACoAIAAAGVQgAABdQCAAABMYA==
Date: Wed, 22 Mar 2023 17:02:52 +0000
Message-ID:
 <PH0PR12MB5481B513EF0CAD4020A4C246DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230322125153.128385-1-hengqi@linux.alibaba.com>
 <87sfdwhkxq.fsf@redhat.com>
 <PH0PR12MB5481FCF22C47F2D23E6638E2DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87pm90hhew.fsf@redhat.com>
 <PH0PR12MB5481C1E2C473B2F13D1B8D84DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87jzz8hh1w.fsf@redhat.com> <20230322124508-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B3FD31F529EDF420FACEDC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230322125058-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230322125058-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH8PR12MB8607:EE_
x-ms-office365-filtering-correlation-id: fc651e10-1f6e-4c25-59b6-08db2af7461c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 g+JLE2N+yT+q2TrH2ZroG09Pv7gRovW5s7Jo1iZt7pq02HPsYB2CLtx29PXxeS78z84PUrV8ScsvU4fFe689XPjewb4G5NtXIKv50GdujJ/a5u4BgPIjrDsSenqYG75GDwCwYtIdApHviOH9oZmsaStZaUshi49atvpPacb+0wFS1g5HpQl7+9K6oizP9l6HpKdaN/Skt9VnLeHRE1e/c55K5KcgDMggCnZILqgD9UpDvTnuBehvIJFZDbqvXeSQAIdFCUzMrbd+WesxIPhWFb8U68U36q8K2jO/VNjYOxkEZyIypRUKgZr6UA3PxZH9bia3UXCt5LMtlLgeWtxnL3MB4FDt1LUctYFWtlZQEPIWwdTL5fZxHCkMiksq/0sm7k/mH7h9POByObDFDLGAP7it9C/IQkLOSG9RN4DOCMM9UzoHpm475pFnkgAXeXxRpAkCj1Vmpa7wDIFyKTVVbuY2B9zQ5felyrWVZpaytur9XW/bgXSswRPHcHFuL9Fg60TA/j363Fr7Q/KUAhGVIweUabuvuKBjpF7b3r5/VzHmG6LrgeUScIiCgAc4vRherQglMxtKDlE9SH7Fd7Dn6S+wie+WI/eCwNbdWMdkIs1gB+nqD5x75c83CmNFd3yze2e1EIHip1vXkrHRGs3N/actdCnrbLWe6bbwbs4zlpW1oG1y2ArlYIPMIN3EdQxPfQv7GseRTs2+iF2fl53GPg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199018)(6506007)(26005)(76116006)(4326008)(6916009)(52536014)(71200400001)(66556008)(83380400001)(64756008)(316002)(66946007)(66476007)(9686003)(186003)(54906003)(478600001)(8676002)(66446008)(41300700001)(8936002)(5660300002)(2906002)(122000001)(7696005)(38070700005)(38100700002)(86362001)(55016003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?p0pqLyA5P5NLvlC1ULUVHS6RIwmCMwwU3xhA5y8qxLZEt2xc3GVRONvjFiR/?=
 =?us-ascii?Q?Di895ZywcNrEIcuo/ChKn5+n0+/KqoDnvQMqRoykhoQXVKTWBa9sig55RroU?=
 =?us-ascii?Q?NpkIelPa7HL7nT3jv3nL1nY1GqdDmCqwQyRZ/98rbmvH9+DU+E2Dv16svhbd?=
 =?us-ascii?Q?1qEqUvq6L9/goHHqfGw7F8G1GVSCNapj+I6ElPp+EIk+EHiN+BatGKpaUrpq?=
 =?us-ascii?Q?XpDPK5Vq3GZfWi+7Xevppd5HXDPntl9bjo+4HwaimZSLUo8O6Ehz6b1psyom?=
 =?us-ascii?Q?g/Kr8Xs7xSWAkekKK8vfX8LQ+pKST/zDc/rvFOKApF3QFu51Zl2cVwtt3m3m?=
 =?us-ascii?Q?mXSd+9kIIPb12aIhGi/POCN32tx/32rWwxiS8uVJ6r57UvvyvpbNTWJZ5FzO?=
 =?us-ascii?Q?//crJV5bf7XCKf8EdOWDAp9uJY+93s4Hz5h/ywD59py85K/hfALeaHt9wLXM?=
 =?us-ascii?Q?9nzr2JcVwWMwHwCfQVnxgRJIWeTLHf/imT13IsrEgRJ0Mto+7k+BHLikTgbp?=
 =?us-ascii?Q?P28Szzl5bYbFKWU31M/OpVUROe4Jco2Fc1qJj+lmLV4IVl/ewxB+2A+hiGLZ?=
 =?us-ascii?Q?Y+Au8XOev+neBAbDAUubzKYLBeomKFYvKmsZFLnrV7bfymeg7uW4mkmnOvLx?=
 =?us-ascii?Q?5xVvDKHxxEIZYuzyYp7QPaqlYryP9I6G7C6Xivvkfl4ryvJMMEZig8Jl1A1C?=
 =?us-ascii?Q?yLcgvwjDsaZlK0LVlozD2eTmmTQO8IdGjircF5RybXpCGWLUaH5qSyT/81Ux?=
 =?us-ascii?Q?Mh3HrRYdYnR6A9Y667f4xyJOzpTVJuP+gV0xhyarEXebzU9NCT+yu+niawUu?=
 =?us-ascii?Q?57q0bE09JvQ+b3zEgPsk4qIVYlYzVrKdsFYuX1kG9ZrxnA9uT0FcMa+0AJ1C?=
 =?us-ascii?Q?zf9ncYmM9eklowBbbnyyXh3bDmEkf/gDZ+7KelfWWt/BsRY9gu4lMIP2jncX?=
 =?us-ascii?Q?5khP49hfW1hZls1uXMe8Ncb4r4TyEKZMFenN+q9biT4TKSN034toqPGcuebl?=
 =?us-ascii?Q?FBYpTI6ErlRYJlYxzHQ3Hm7FRJGr/r76OZirwRUFrOBhu8qtvEnzDzBS/Q2D?=
 =?us-ascii?Q?1wdI6L9TW/VAgMSjuAa6sgAmujRcoG7QPcXA6EimePEMPD0ZNgu//pPV7V+a?=
 =?us-ascii?Q?OnVwIRZq/Sf0JmJ+5I72CBULLxivUU0eylh/BKpa3JXYFWY2blITXV+uMit5?=
 =?us-ascii?Q?ej6ISODbBiiOlgbdTXUAu6y1tZcxRCnfNnbNzgCI1FF+C9laebId/sOulotr?=
 =?us-ascii?Q?jXWHzpY7RjYVq/+RnSop2Hv6RE72bZubWgFhujLymaDrAWeohZaQCFskYmm6?=
 =?us-ascii?Q?crolafGfAJMpUHASSRqiV3puMnrI48olkqvNfAV+Fiu7AVlNmxV8xTqlXSe8?=
 =?us-ascii?Q?GaTCEewi5pRLLIoT1ROH2/JdTyYr4Kn8Rc5hUKfbErcB2hvx/+j9snmQEijb?=
 =?us-ascii?Q?94dEri3Fq8OCRbVEv2PC7sasAcA1A9aQSC5rO86UeE4fmW9G9W8h38Dm++fB?=
 =?us-ascii?Q?uVpSZ3K+CgCSL2PoJD3rpLpw8QP3/1tT8M4jwWvrphUSAUQk4Q6dipFkmpb/?=
 =?us-ascii?Q?e1KDVkS/jDDlGgHFyDw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc651e10-1f6e-4c25-59b6-08db2af7461c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 17:02:52.4452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JpY/5p+tKRpZgSQIW7A0mpHjpJZHByPOxAFMQixINXxmN0FzLIdwlYfKjGht26uyqfD9/w7Lm3B1D8fOl0hpmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8607
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v13] virtio-net: support the
 virtqueue coalescing moderation


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, March 22, 2023 12:53 PM
>=20
> On Wed, Mar 22, 2023 at 04:49:58PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Wednesday, March 22, 2023 12:47 PM
> > >
> > > I agree with Cornelia here. Yes if devices do not want to trust
> > > drivers then they will validate input but what exactly happens then i=
s
> currently up to device.
> > > If we want to try and specify devices in all cases of out of spec
> > > input that's a big project, certainly doable but I would rather not
> > > connect it to this, rather boutique, feature.
> > Both of your and Cornelia's comment is abstract to me.
> > We cannot change past.
>=20
> But we can make sure things are consistent. Currently we don't describe d=
evice
> behaviour if driver is out of spec and I see 0 reasons to start doing it =
with
> coalescing commands specifically.
>=20
> > For the new command of interest here, hen driver supplied incorrect val=
ues,
> the device will return error.
>=20
> It might be easier for device to just set NEEDS_RESET and stop responding=
.=20
This approach of treating all errors as a fatal category is completely the =
opposite of making the device and driver resilient to (recoverable) errors.
We shouldn't go this route.
Different discussion...

> For
> a hypervisor implementation that's often better than returning error sinc=
e
> device state is then preserved making things easier to debug.
>=20
> > How to implement is upto the device to figure out.
>=20
>=20
> what to do is also up to the device.
Previously error code as not returned hence new command cannot return the e=
rror code is going backward.

Returning the failure code is a way to indicate that the driver had a recov=
erable error.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

