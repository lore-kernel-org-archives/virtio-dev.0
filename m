Return-Path: <virtio-dev-return-12414-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AB4C77B61
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 20:20:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8F66042A6E
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 20:20:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by host09.ws5.connectedcommunity.org (Postfix) with QMQP
	id 7553D3D8D4; Tue, 25 Apr 2023 20:20:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1D1EF986474;
	Tue, 25 Apr 2023 20:18:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V69rW7AW+bRHGYB+8hUZBSy307A92mJuYTSzOh3tENUTYI4z60tlxFZDzBeJpr7h/Azaj4jDhuJtuF1hGBYzfxj25KwTHQpMoc+t3WxFP4gbndVl1fqcXRixW367RnSnXukhTSpP1UR2MtjLITv0pxBbMhGZkZ9xz71/84KB0iwg362l6npntCcnhZvJc2lXQRx2C44L6OvBGjSwLR34q+r4Dk1pjbrfNJ6uXeXdNY7hP1tJgmAf6B6ny+BZLCVjI9gkRR1rz3RGfJsApfkyuga5MTckip3Dl0SVyVpXPR/vxDWppCv1oqDDhkk9fQi/bSB4/3dao7Plap/t2mo0FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/slH2Xk4Z+86gbPqgC5qRQCW3q2FfMo7HToV04iYma0=;
 b=kyeR74IrMDb2O1HD1qtDWwPBZttKxmkexPb6HSg6K/jtoDpf7bpM6NHZYxHPTmvBWwWtHztQ6SmqBOeNcq/AorpZeCPOk6BPEGMn2M47b5tmZYh72W5sgwtWINb8tSJ1NbFFB+79MZfKUphJvEuMK4oW8aCogBHh6FE2v73F/lBj4J7LdR2NbY4BNWhp/0seo1wvnFXISGDbmCmJk8ZtguPRue8nNAUFpqtVwNPw1Xg7U57v9lzjmA1TuQ5QVkfrtjSNl8sG1ZXPs3hZUT7OqXX8cuX9LfEfvBOPn9M/iVdeBpiHwE0381p6x/Tg3zUc0IqtREElxkmCaRjC9Wqj2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com"
	<hang.yuan@intel.com>, "virtio@lists.oasis-open.org"
	<virtio@lists.oasis-open.org>, Jiri Pirko <jiri@nvidia.com>, Zhu Lingshan
	<lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf
 Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [PATCH v12 03/10] admin: introduce group administration commands
Thread-Index:
 AQHZdswMuKG6jk+9I0m5FI6AWEnz/687YNgAgAAtfwCAAHQjIIAABG8AgAAAneCAAG1MgIAAAKcA
Date: Tue, 25 Apr 2023 20:18:54 +0000
Message-ID:
 <PH0PR12MB548102A2FD30A15994D6C0F5DC649@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1682354275.git.mst@redhat.com>
 <79c27bca6f72e4ea5d1d0e3a6b1a54369b03fb30.1682354275.git.mst@redhat.com>
 <e9256f17-f9ab-de6d-0377-d9fc210a7cc0@nvidia.com>
 <20230425020925-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D9A42176A43075D4AD4DDC649@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230425092651-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BB7BCD1D9FF68395633BDC649@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230425160346-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230425160346-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB5641:EE_
x-ms-office365-filtering-correlation-id: 3ded58d5-f36e-43ae-8797-08db45ca4ac8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 QBuvu3BHW7fotBQ8ONBPgG13Wa3Yaj/w/noCJ09hfYE0HPv6UHftLHwg7UgLBsTvd2fDs2eI9Z8OKRi4ewb2pDf8Z+o4dhMvZobvS6X2B8sLZEJVcaHoFdmT3JvaOb1DRzwH1rqBAkC/Q+GF0DMWcM6Mg0s+DOWUTpRN3wNbLX8EMNML7TSlsBkcXPmv5HBehggJJm0y/AiE/17NvoxhM1mWoy/P7lJcCce0tVMMOnPn+BqxT6NbW+EMlxJEOv1dnBDzF03lQw4LPfs5NbfC4IaSein579wMKdRFdoBkOGOANdufdoOSXDy/Y1UV7Y+OSV/9scYnEaksVORtqv+Y3p1KCOtru7CMlLHia8abjYaTw4vee7TNZokxIOIS3R7Ww+Io2QmraNQSggTi67WgYECn+7rKzoLgOBI3AlKfDzRaBHEB7HxkiY7STmZiWrunvVXbHg/exGWcfNiXEeICr5uDiLY1XIwh7g/VS3gYbXoxKZm12svYpHgGQKQsBinN9vYBsQkzLsoZl1TLgJPjekS+8PUqiNgaiTPNeUFkcKM3IUCI+ryYHqRuBruc54FVnV/c/BHPPcMm57RU8fnjn6c9gy+vtRxZNDqa4aduvvdH+LHC9ezwNXaknaeTme4f
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(451199021)(7416002)(2906002)(38070700005)(38100700002)(52536014)(5660300002)(8676002)(8936002)(55016003)(86362001)(33656002)(7696005)(71200400001)(107886003)(26005)(54906003)(6506007)(478600001)(83380400001)(9686003)(186003)(316002)(41300700001)(122000001)(6916009)(64756008)(66446008)(66476007)(66556008)(4326008)(66946007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yzZT8GcfIcn7GWml3jexF+6VZ0Yyni4FGvIb02FTUP9iuZ2y9lECl3PPYDly?=
 =?us-ascii?Q?TRWvD7BRBa2TGPdseiB7H16tYkH2pTmqYlj5WwN2NLCwHwDZEKzW47fcPBbl?=
 =?us-ascii?Q?b7UPtPtW9f6xwXAySbIPe7RIvurdJl8hDpigyT5LU4h4Lh9mHvef+ujaYGcB?=
 =?us-ascii?Q?Ch5Sqmri0k138EmfMep8Q+4l9cVnbkXeMTK787BU9F2DUlBCdW0/HdzDl8Xv?=
 =?us-ascii?Q?uzNwM8KOiJS/qtYDNV+Uj7dwB5QKqbsNamEuDSBQpe9yGQ2jUqK5vk2TSP78?=
 =?us-ascii?Q?6NX6/qZmHBlWhU/TCQ5x4nmMoo6oz7fXyoChFMgMqF1iM35QEvnlWnnefdD2?=
 =?us-ascii?Q?O6ekipY8s23FcR4EdgiTJesBX2SjUHb22GGlyOcMqcdo7px9SgifDPflGDZU?=
 =?us-ascii?Q?5tipm4Hf2vxBKhR/ycd/X9T0wQi+IzON5LixIQWfSXRUVSxK7/IdOARB82sW?=
 =?us-ascii?Q?NnY/nGd4ffuwvLSIqfcaOtyDyxxchenzDIlFEbUZ2Bwv1G8F2Wvw5yb7a9mr?=
 =?us-ascii?Q?YefngXPYexpeRkRb9k4zpfBIzvs1MajSPpUuLdfdYQFsTrEDLGEbFdt14xff?=
 =?us-ascii?Q?1JdUpsxw1f9jHfaLtTnew4pOhiWBRyrdDgoUYHAIiEDWcVp+5PzRA1d7p42v?=
 =?us-ascii?Q?f3s5P2UD4rrTxBEthKaIp3qdCCR3vcPuquwPY15cqYMYye5gSwxppzF1DaR4?=
 =?us-ascii?Q?TRxwSHjVe/7Me3bOVcjazaKv05ymdLJXdzwtPUV8A3PpuxAWiNACioH3rFlY?=
 =?us-ascii?Q?qHA7yU85cd5P5b79GfwYYDxyKlLXao5b/v2CjFpoA2IWmPvgStyFLrnSn1nQ?=
 =?us-ascii?Q?XdHuGTa/aY4d8tJo9M6eWALXtUjoMzphiIKnhBEPsdc24luCwPlCtH0yn3u2?=
 =?us-ascii?Q?FnMoh9BFtRgRPyTHhSb6tjokWdghb7GOmcC7u1odO0/474v4GUyG/C4s3SoH?=
 =?us-ascii?Q?mQ8NQykSWUFetj9RaWt/ZWh9e5VgKG1rNcHURUBOqWfgp4foVQfqpFsHTAJo?=
 =?us-ascii?Q?Dq4G9V8gmNx9UWrhiqi1engKfZp5AXdRUWXjXuBK1JVECZWF8Fmd6E3ct99n?=
 =?us-ascii?Q?LczdzmmJvqSkicSutI7J/ju0kPqxLSuPsdG9i9vskX/Z93D3NL3j9fDmz8fE?=
 =?us-ascii?Q?8FpQrN/+X+DYMaJG+uOKdi8ubmyGYoB15+Qo37kjSxP9SxjxyrxpCfW0EwYm?=
 =?us-ascii?Q?JSRBawY/TRKOlzwFbDb2a/1ELbAEC0qhJPpxgkxtAC0okq8o6tr/yEd+sd9E?=
 =?us-ascii?Q?wkQvZ3GDVGR6Y5qTQmCRpyBXxtUynFTvZ/RIz4oSIK2LYJ6JzXexWJVsn3Ls?=
 =?us-ascii?Q?zhHrnxfGj/2wpkWsSWl/MYzpHpV8jp9XZo+QCyVX+jceGZ3Ypp//iT5n3Ztd?=
 =?us-ascii?Q?quS4QjkYlX99YguGuBnWM30LiUys0FobyrhTZvI79xCvzscquN3OYbs+079g?=
 =?us-ascii?Q?kaZVVmsYXo0ULsTI5r1ftvhPt5Odl1N6Wi9X3y5Eq7hcMSz7a680P8AgQwd6?=
 =?us-ascii?Q?l59vxMx5zJMxA+rC18w8PbEMS/eGjQJIZk03SHof9p3FY9RbSsyt9NbeE6A6?=
 =?us-ascii?Q?tqYPbMjNKyb3u7yuoXo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ded58d5-f36e-43ae-8797-08db45ca4ac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 20:18:54.3168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J7y24VzVToJinAnS2nSre/XWXEMIrnOXUthNek+BNhdQ6295SmD/z9xxs2dAA39AN1ArbI0YS1uTrwaptl+4Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5641
Subject: [virtio-dev] RE: [PATCH v12 03/10] admin: introduce group administration commands


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, April 25, 2023 4:05 PM
> > Ok. I feel it is still worth to have commit log updated. If you happen =
to revise
> v13, please do.
> > Else its fine.
> >
> > v12 surely doesn't merge cleanly. So v13 is needed anyway.
> >
> > Can you please generate? Patch-5 of v12 fails to apply.
>=20
> should apply on top of 985bbf397db4228faf3ec464e838687dc4cb4904.  master
> will fail because of the file movement.  I will need to rebase to apply o=
n latest
> master, I will do it before we start voting.

Ok. sounds good. I assume you will post rebased v13 with commit log updated=
?
When do you plan to do?

I request that it is better to rebase now because legacy related patches ne=
ed to touch the add the PCI extended capability on top of your changes.
This results in further manual merges for me.
Better to do the work once with one time rebase, instead of both of us.

Let me know if I should generate v13 fixing above two items as you have hol=
iday this week.
It helps me build on top of AQ patches with one time rebase.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

