Return-Path: <virtio-dev-return-12018-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78B7C7619A
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 13:02:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F342A29FD7
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 13:02:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E64679865D1
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 13:02:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DD2229865AB; Wed,  5 Apr 2023 13:02:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C6AEA9865A8;
	Wed,  5 Apr 2023 13:02:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJvYYQ0AlgSDszDh5gevAC0fQLOU37JRZDh4m8p2w/3/RBMF09+EuDRITru8JT3/N+DjJkEyKAyPTZvCKLxuWMM2LECehlA078MEwshH2VcWUSVkOg84QBs39pzfO8pf9uH/LnCj3VJGhlBAkRy6hud3iH134Y0iniB7MByax8VREhgzKd6HG0W0ZUGL/l0ELDWC6Bhy24RvMzU/TEIFN59hvwa8PgzupwATKJsd4qbV5lAK9f3mBx2q/IeNA5inziJy4nGWgKc47HgjmIoWjEiMJptQAVWzMgAneBBX9x0SS7t0QMTtAKKn6cmL5ZzeFrUosh2NPf0Fp8QI7GlaDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4J9ivhvyjZkZfiMmK0LxI1OrxgqYA77aSvcidiODoM=;
 b=UNa09XflaI+8eHRuPmbRsG0pnqWoEk6ar843ZySMakTlhALoRMf8+mYtc2zxhTF8P7p1CsbBSiNn1Q/MYFuFVnIDey1zu5TGdpQ/FdaXRQ8lw5g143rwEjIfKfxmlJ4XtXJ49IVjhk571a52JI2vsI6zgQZl/JDArUFq6HbMneX3/ycwVVPa6hrxUFXxup7kYtaepug8cXQSjNHnUOVhCYJYiWMAIEInbLyofsvKxI9+r1gPzMnF2gRKK9WECPwz/JA8IyrQAuBLmV88kDf9ezb39mpfujvMyULBtYnzzd3VtI4m4bBSUq6Lo1GB83TN+zimePSM7zGLGyQrZfYD+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com"
	<sgarzare@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v12 10/10] virtio-net: Describe RSS using rss rq id
Thread-Index: AQHZZ1r/FjNov15+REKmTWIbKzkMTa8ccEqAgAA+e2A=
Date: Wed, 5 Apr 2023 13:02:24 +0000
Message-ID:
 <PH0PR12MB5481035B8C5D113CA76CB6D9DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230405010657.612529-1-parav@nvidia.com>
 <20230405010657.612529-11-parav@nvidia.com>
 <20230405051637-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230405051637-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BN9PR12MB5321:EE_
x-ms-office365-filtering-correlation-id: 116b4184-8d52-446e-79ce-08db35d6005f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 aA2pCuNBxafo4DlwxB2eWYmYBOi7LlFGXOMYi/UFPKpI2P29zrHe5VTSLKW782bKxmZtQcvY4q7sjQApy1y6rvUbyp/TgZA6yU6ZFHqMUTRNa2dirrN/6fgCwTnLC+DnTDOFNc0PnTHY11LlnkrN+vdPkBR8eub03Fqr16fzmI+Ui5jYZ6J9vg5EBCkf55phxVfPiHoMNxkm1jXt7i5Mdrj5CgPvmxerkCeLGdm1GJ4IqAvB2qItaAi20CRL4OeWe78wV9bAhPNR95OuwTjV5Bi58uvaWtJ7lR7n8J+8X2wR2iMdWsgEtldoYCChpupqLIhtRk/1cgi12ODew3UThuoIMddtTxGsVOFDTXhqKagLvFc+DuBlimMW5pHSbKAKhz8gtrl6H2bN52tPIQH9a6QVf1tLdgi7ssuyuLTTf79YCCDL24tg7lP8JXW2v0bxlOTQPgss9hD04y/c43Q4AKmVj/1alYt0/jLWJm7UmIbr8cfvcaZuxXAK5JlE5IzOOR5mqJfsZI1wodFW7orctHNMrWTWKCpQ0o4LfiaHH96wb4wTNZg4J21rJ1zGNZ3EMDlG8ZxUCvdtuUAk8pDmdliqgujNWB7DbkU8omdBl7M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199021)(7696005)(71200400001)(478600001)(55016003)(86362001)(33656002)(122000001)(38100700002)(2906002)(4744005)(54906003)(9686003)(186003)(316002)(107886003)(52536014)(6506007)(64756008)(8936002)(5660300002)(8676002)(38070700005)(4326008)(66556008)(66946007)(41300700001)(66446008)(6916009)(66476007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BcqAbVD0B4xWGQWGgG6Vw/JJqjOtf13XOHI5guZMyN3f9S2MJhz3y+YiTas6?=
 =?us-ascii?Q?0ZRHWz7XcyKRh4TuuvdbtrG10rWohkT/kC+3piImQI4ChAJxCTPMU6SUwYUS?=
 =?us-ascii?Q?8Op1yf34zH3TU8fpxtLFMClT/3I2MwHj7bP0pRJljY2tTH8DoSnayqWOT5r3?=
 =?us-ascii?Q?jAcT3vNRvPgfhd5/zQcTLZ1QNp7MbiwTJLATAXha1laHr6ri/GEKjsM+A1Tc?=
 =?us-ascii?Q?RFLGLX78DKdA6wYH7OFTGXZ3+Xs0kp6Rl4G7BS6mSnjLheEp9iuumJaYs3th?=
 =?us-ascii?Q?r3M4pIhOW9RJr+Qij5P4GNHKLbC0uHRq5LHvNZGb6lSrJZVyJ01VpK361yq1?=
 =?us-ascii?Q?1NsqAfSxjWenrL/RpUld0ReVfuX3Le8dXdGP/XiaIpPLGHBEh8RUarhKo9OR?=
 =?us-ascii?Q?QWNpq8ReiS/7HNJT9EHVdD1IVyHAdS7pg6jBlmU6vD+02NFKVwsdVy0DRUun?=
 =?us-ascii?Q?gycWXssYUACNgvfkA7iYQVFy13SxoOxEpiJirREb3rp9wV9a7dmDLunGrAUw?=
 =?us-ascii?Q?NfmF0brUTYPXp+ElJ7S/i7PDK0TVBHlzMpE/+I14j1d78gkGDNxKLmhBAA/4?=
 =?us-ascii?Q?0vK6KISmZSdqOy9x6Uwyk0OAE6IdASbCXRDQz1uj/NiFV6mBWSM4AkzpqA6X?=
 =?us-ascii?Q?xHyKA+72OymmIIcuOfFBtZuDkBvDIHUoXbWVqJdM87iMWyQumAlqR4eW1jM3?=
 =?us-ascii?Q?5n5ylVk0MM0AmeBJC/LIZPRgMTwfsM+nAjteOyYKS9VQVpvd4Jky/p2R7fcm?=
 =?us-ascii?Q?g3rszQo0gKBd0oKqlfYTBaPDJdIor5wDX3g5m8IbtnlyeRCsAYFnvTdXQENC?=
 =?us-ascii?Q?R+XJDt/JyvBSCKybWkV6YdhEw3ezEbQbpde/Qaai0HiqLH/auVSzp8IOquJe?=
 =?us-ascii?Q?d3jvfy6Ck9xp5GysPIe33pOpx7wdDFNtAr7xWPcawgHQWRs+pG1cWQBBsMCg?=
 =?us-ascii?Q?FZxIjqm+QkVQGNdZKoAUV77En3ZT+PhT2ByYdmz70Z/1HMoDJ/0iuTlhsNpR?=
 =?us-ascii?Q?HnKEnq99ra47hejukwyFBxhMn6iJ6f3ArB/n3Qb0kHr4wnTQ+fyY8V1ojHK5?=
 =?us-ascii?Q?0qA1ALsHedp1LvbtWgoxBSbsPEsel8qsnCvyjvhBVKEMUxrDl7Vcn1lIhAiC?=
 =?us-ascii?Q?X4BZ6b5rrGcZI3HZYFLdpXyt5osI3TxFvwd6ZtrlvX7RSempQziKcBT7TVSV?=
 =?us-ascii?Q?iKjOTrhr1yZVxx9mSFO8rhJVG+A3PLisDAWdEbj2QkT51hR/dpNer7Kn59VH?=
 =?us-ascii?Q?E40ar5i7GfVFBQNr+ik/wKWaCbeTFOMx1eYJltAAwXmyhtwFGNIKkkXDWs9Z?=
 =?us-ascii?Q?O+Lep1hfinPNhouf0jJ8Xh6/GUQ69a+b+SR+L4bn8gPsUnW/eOMgVz80UNoN?=
 =?us-ascii?Q?d78qSryoFrjbIROX1s21UcOw4wUBh8fsYLgpofUb1OuEVGBGy9GRy3l5/+Mx?=
 =?us-ascii?Q?yqI7qY52r2CT5OEoUra35S+kILoe1djz8hZBkSLptPspb1p996ITuB+V8M3W?=
 =?us-ascii?Q?cs7HM1SscwikQMSFNuAZM+fBi56Fa5fTaI1y4+KEMpOyqEp9C2+wz2VDwrHD?=
 =?us-ascii?Q?h6VqvnMCl/y7FU/UW+AwdLCzW3Aj4D//SGdD5CLKranJeQjo7lWwAbi89iKi?=
 =?us-ascii?Q?BYGtVxlUpGU1zFUV5YdqLmQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116b4184-8d52-446e-79ce-08db35d6005f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 13:02:24.8072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QT37IZDmMECkqoiuKN97z1zmSQ9zuqSNKX9JabJpp3Kxsy1cmKXiwAopMF0xRT2SwrABtn6y4Zo9pIOoi8jFZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5321
Subject: [virtio-dev] RE: [PATCH v12 10/10] virtio-net: Describe RSS using rss rq id



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, April 5, 2023 5:18 AM

> following format for \field{command-specific-data}:
> >  \begin{lstlisting}
> > +struct rss_rq_id {
> > +   le16 vqn_1_16: 15; /* Bits 1 to 16 of the vq index */
>=20
> Do you want to then call this vq_index_1_16 ?
Yes. will change.

> And in the comment I would just write virtqueue index.
>=20
Why do you prefer longer to name here instead of abbreviation?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

