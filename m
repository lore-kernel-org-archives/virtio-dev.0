Return-Path: <virtio-dev-return-12635-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E7AC77B7D
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 18:29:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DE7D542567
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 18:29:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CC2359865EB
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 18:29:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BBDEB9865A1; Wed, 10 May 2023 18:29:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A71339865AB;
	Wed, 10 May 2023 18:29:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCS4OsPEIyYyFAop9gLoaawJRKg3MKrpzVDj7/rKSzh2cFe0KwCQSOTlEeEpE7xzSJEEsfPjeVF3nO5l7QLE/w5dT/R+n6sP/0IN2bAPQJIDp+Alh8vJeXAlTDYA1gu7BUwhOxYUR2Vhb3/Y+ysC7uEOrhtNx+LbQ+jGM9fc8UQCnoa1D5QMm716vTfeleVyAyiRurunp3YCXq/8qpwD8BNOqCnEXOfCvqfA96Frt0Qto5rx9zds8WTNj4y7baqSBe6oPE50DAbfgLcm1rkFaBJNAT8/PRRPpnqzSclKNVPyw2ZhavS0bnbWvV/C/Y/cvVUMus7TU1Iclo5+ePQhIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bv2ua3ngVjsBt/qRUNfkugbPYwUyeimUWjyrkuCt9iM=;
 b=TcV6pkIZopM2updFussw64T0vd5f8IjFEu+948j9lFkXsBX7fg8ByDgmr59iA9cICSmWq07LyWqPAaepOQhQukJWmDlx7g5eB3rV3VDDDkihEmiNX23ydVT4xVVg1pLE3ODCfWH2axPK/YiYuTU45t4fpp/2gtO098J35R4LziISgDm9BnGxz19Qcpe1M/dAgxIwJ6c10GpWSzxxu+mD315w2+opW8pQYtxwj+Xazeq+FGxlOgVP+7yPoSHJnU2tnlkFsLxnMCgkgvM+njVP5OxeI+5WyM6RmcOxRelG/PCQ5JnEcg17mQxnDTpZ/q55/Cra8PCWHLupV+WrBPM0nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v3 0/2] transport-pci: msix register desc improve
Thread-Index: AQHZdGE6BcXrBONjlkOC0QSro05TaK83HJUAgAN5WOCABY/KsIATzBIQ
Date: Wed, 10 May 2023 18:29:32 +0000
Message-ID:
 <PH0PR12MB5481D376FBD99E8CAB26459FDC779@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230421145434.83774-1-parav@nvidia.com>
 <20230422061011-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814D66357FCDAE3B3869DADC679@PH0PR12MB5481.namprd12.prod.outlook.com>
 <DM8PR12MB54809734DCE2820CA728AFA0DC6B9@DM8PR12MB5480.namprd12.prod.outlook.com>
In-Reply-To:
 <DM8PR12MB54809734DCE2820CA728AFA0DC6B9@DM8PR12MB5480.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH0PR12MB5648:EE_
x-ms-office365-filtering-correlation-id: fd6ca433-7cfd-4718-4f9e-08db51847f8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 oC85Bu449m449xJtV3o9B4Uy5qoXGWMLC/FQKeNwwh+TkODE+a05ua0Ypdx14M3dM5mNofr+IwMsiZ+vX+dJCbkd9INo/DffrC+IuUimxYvTyZ8fsjJ1L2bi3gNJUh28Ojm57wQAqlz5eaVYtw81/3riXKmPawBKqiEqsGjOm8ITvxfOEDAzpS5I4aPxf1Wc+vnUQ9MdtY31LBsN0xR0H8Qqu3TGEkNx5IhgSQsogGSLiPjXe+pI9EKykCzI5+upCpxvgJayPD99fAG/oVEfLyM69jGMJ3tOGPfIOFfQvWJRvbc+NucE3JYBaimms0Kx4O3v1n1mo6y4Vw442wxMvTM+Evs1aVS4umUZEE4vnv4B9HKypbnZObodyeSRf0z7UX+Vv5NZuTLINk58mnk/BhPme7EO+p3TbMn5lxn1xgTH2nmgUV1IMmbC/MKpO7CY9hB/uvPgaZSSv+9FRA6Psr1RfW3dPO44p0/gM1S3myIYAjh86+ieVbAML7oWZEKfq2qiMZrQyJT8UMzYe7GueCH2T7qUkzNeb4kki65qMaPEkuALaKpO9xyzovmJemhSgizTavULFiB53q8Br6JBQDRXL5kxHcHyNWK8KcQTruYfWO3cNpQvOe5qe/TzKXxQVvAbgPnYGefVG/J4gD0Zdw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(186003)(55016003)(54906003)(86362001)(478600001)(33656002)(7696005)(71200400001)(966005)(38100700002)(38070700005)(52536014)(4744005)(8936002)(8676002)(5660300002)(6916009)(66556008)(66476007)(66446008)(76116006)(64756008)(66946007)(41300700001)(122000001)(4326008)(316002)(2906002)(53546011)(6506007)(9686003)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4CGzskKCUwcVZsttNTLVevThWoEAsrmmS4dHj9SE77YLBzOoNDhp21nm7SlG?=
 =?us-ascii?Q?nHHN/SHNwNyUYoOKBLXNnVKIQa57byDsyARy5WTeCtldqdZ/Wpgu9C8HomP2?=
 =?us-ascii?Q?17FP/3fKXiGNOH0TMTOOGHn9DbzAuafShVwhQm3YcibD81We+Wc9Eyyk9Zwz?=
 =?us-ascii?Q?449Iek+UEK3s1Di76aYuWfVHhKJETQR/CCHdxXlElhtT1QxslhcA+CVNoqa4?=
 =?us-ascii?Q?PGoyy3NyaPENnkY7GYKta5ms+F4672AzWql6h/qQIaWItUcdNYyalZVabWWK?=
 =?us-ascii?Q?yomqoEtSCRd4n6EG41yWd0JiSPJ0w3DzgARGqVdPqYkRNkL8dcYSfZ04Zl4s?=
 =?us-ascii?Q?XbE9IQB+Hm8Jonrq+OozGau/QGVnaEM/jz3rX6V9xjQJjDuNiMKe1BFbct7x?=
 =?us-ascii?Q?4FAT8cB3r7mT7RHADsvLeU/9iXwc9BxRPau78tB1P6iZbH8sCJbm6T9khaCj?=
 =?us-ascii?Q?3yHbWw7asy7Somv/EdFgX0uglWVIBkEl3sIIbZbgyakPgUHUJe3LNF+d5Z5j?=
 =?us-ascii?Q?fKEPTPbnbwTK/8odLzZwoCOgEUJISaBN5T6bSqQc9LcEg+LDW1z4g04dPx7A?=
 =?us-ascii?Q?r8sJq9oF+of6uOWwMN3CDCcsSbxHEcXsYw/6+ycIQk9Wm0rerOJ/3K6OW3OZ?=
 =?us-ascii?Q?gwwGHyaOB08uZbghEQ5aoKqvbED8OP9lVX+F8bftoXBxMgaVcnwS3wZJ9pbI?=
 =?us-ascii?Q?jl0ugqXMotmYbb+eg3oWUqgGWDg+M2lL6uLQgIUpFBwqn2WlRfhZUW4do9HO?=
 =?us-ascii?Q?jq+7lfGwwyrwEkayEbgwW1yrbC/J7nscg6fKu8oZwceDJ3XTuwk1EAi013+w?=
 =?us-ascii?Q?4+8JSp2kNgPgwSGebwriLZCRkVsYpTX1me7cwrHCe4WGLxQ7XC4yJVa4wf9V?=
 =?us-ascii?Q?0i9y7prhWoba9/3Ff2U+wou3utDkhZq9LnRiKdfFMORErYLn+pl31d2hf9FZ?=
 =?us-ascii?Q?YEIEYu32pnmpXbveC7klJVu8nahhhqWalMmD8sBqBF8DDQ6QnFT97xP63oOM?=
 =?us-ascii?Q?PJfcqQ8K71Nq7EGAv0+mAtcMszuA4YU8Ho2Jm30HOGAAKeHsfOkmpUsnsLH0?=
 =?us-ascii?Q?MF1IKuVVv2xWRckYrNkEK5H+MN7vF/HLSu2Tpp/ue5+uK7Qc2JaaV5KvQtbP?=
 =?us-ascii?Q?xDPtxgrU2rAUox8OrQ0EAYCHThcDAEO0bxXRLFazq1hhkoqg1s8YM40F+4e/?=
 =?us-ascii?Q?g801j4c1AFwTwz75FfVRkSren4QF4b63rhKQD5eD7BylnV04duz91WfzozsZ?=
 =?us-ascii?Q?gyLbOf+qQOtqOWvmGGuGcX0CcfjhAMC0cJVSLrSL1mrGAqrq1P3JMabpSaBj?=
 =?us-ascii?Q?5jO6KJgMXUGPO2tvZsb0ZXK9PQCNIfnPfbH/kLvXOmpEdHbwnLJiEy6DAZAh?=
 =?us-ascii?Q?isZai3pyXPQ0epq+BmMD8agX5mblHPAGz14oF93VMKk2TVmdf5dLF+aBwbSV?=
 =?us-ascii?Q?mrPEs/goODBjCu6OU87oulH505GvDpRamq7wEWHy37Gue6VuA4dfq/ZSlP5e?=
 =?us-ascii?Q?9xDlLmkru9jWGjrIxI0rt7fAmQqhqF4xFlzihjXmC9GG0BY1UW2lovkLGOev?=
 =?us-ascii?Q?hMDWX1bn+AXpwWRyLoC3kwNBzRaGFU/jNMudwaWElPpqvXsPLFk9/pGC+HlH?=
 =?us-ascii?Q?hs47HpSxn6WKJYQVg0z33XA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6ca433-7cfd-4718-4f9e-08db51847f8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 18:29:32.0154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a9LI0Gs55Fn2OVlSLq/LYgkpZqMxCyuj49dTBZvMQjmF61B37aw4xYNTcJdFsSfgBtyxTKp4EInfJvvDMjYxUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5648
Subject: [virtio-dev] RE: [PATCH v3 0/2] transport-pci: msix register desc improve

> From: Parav Pandit <parav@nvidia.com>
> Sent: Friday, April 28, 2023 12:10 AM
> To: Parav Pandit <parav@nvidia.com>; Michael S. Tsirkin <mst@redhat.com>
>=20
> Hi,
>=20
> > From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> > open.org> On Behalf Of Parav Pandit
> > Sent: Monday, April 24, 2023 11:15 AM
>=20
> > > LGTM.
> > > Given the amount of back and forth, I guess we should vote.
> > >
> > Ok. created github at [1].
> > Will wait for few more days to ask for vote for any other review commen=
ts.
> >
> > [1] https://github.com/oasis-tcs/virtio-spec/issues/169
>=20
> Can you please raise the ballot for this?
Can you please merge the patches in the tree?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

