Return-Path: <virtio-dev-return-11487-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E969EC678D4
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 17:25:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 498D1370E7
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 17:25:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 456E99866EB
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 17:25:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3A2099866D1; Tue,  7 Mar 2023 17:25:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 25F689866CD;
	Tue,  7 Mar 2023 17:25:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QK+iLM/MyQawBCciG2mlLMSo9RXyp81jIzCzrGZ4ok+pqsojctegPufzwpZ7ZLYXGSiWCg897WkxfpB1Gzd0OabYBjt2GOxiYj2v1B47A4cIYvkQEcDgO8wgJ9U6OHyHHdYQn3LenX+EI7b5L2vu67c+O1eg90BSjzr6wclXRy0XTlOSyM8VpJJEB0sVmvBEmAcUupiOxbGN1e8ACQ+bQsewQ2hATVxte82U/N7KsAz+E21hLn04CBZ/0V0dXyWMr09+q7JBjXMfZil47i9GLK2OwuJsJk0UkFQiJofP8kUPkZCiX217X+eLvtp8nw2zRlGMH5OAQGL2d09jxbB5jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4A9wkpTCKYFtmzQwS4h5Ma3X+1WSd5dnCIa4RJwJ/M=;
 b=HzCPvAWS22MK40BzPgOcGJtOnh3T1oPa2MtfoADlGi2t5JSfeKu6Ung5Q/jJCfaNiJGiSmkLmgU8XvhsKWVZXq1WJguMlE8jLTW1C7DUV4PUJYBINEI/CQJItF38c2K9HfyTfLo92Mqt5RjLj6tcE1VAmNJaNDjcGym9I75mgdOcQMhC5UcilHJpAD1f4CPQqOCq1dJJ9JoTvJeyR6ufnnpRUaKajaPwM+Rzm0KGXo2AL079nNR0BrZQe/Rr5vh6s+I5qW6NgCJfLuwKUD/DIA+TFFLpx4v957neVsqmyAQKunxNiJl/FvMnwjVxu/R78d7Tfbfy7mNOcNWHbCQgXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v3 0/2] virtio-net: Improve dev config layout
Thread-Index: AQHZQubqz9wcE7thlUGk1jlCkEp5ba7ZaiowgBSA7QCAAcJcsA==
Date: Tue, 7 Mar 2023 17:25:50 +0000
Message-ID:
 <PH0PR12MB548186EADD442CF688EA21BEDCB79@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230217154529.33508-1-parav@nvidia.com>
 <PH0PR12MB5481865B12E7B23862B0F140DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <875ybej6hb.fsf@redhat.com>
In-Reply-To: <875ybej6hb.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB7451:EE_
x-ms-office365-filtering-correlation-id: 6b229d4e-ac7c-4b4d-6388-08db1f30ff3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tijw+c7HLzSMtiUGjM/gCy43KUCm/zRzJ+9yIlkSUVAXpEOn3uR9bamKJEZ4HZ/okhLp0x5ZK4wIo8UtRmbNUOqLu6bQ92n7aWlkUImJjT7ED5rUyur5xlnRDZYwQ3C+kymIlvaas0JteUbeckEX1v6v/gXiux9JeCLgbaedEePudOMOtiDq+B1uFpMXQJOtuF/7La/qgr6hvkqcrrltA93dfN2VPEZsq7lFRgEcMGFfyVXtphEtw/j+AvcehgP7RDlLXQ74H1Bim6ibF38P9n+z/3Jk1x7J3SnS8jemCZZgrBI39/kTtwNxc7zb7BkdjbeU4QikaVwaOlzKSqV59vXInNLxXVoV/WzJclfffLVPenMlAgsCOsqlUeN8qKb0Cue27Ys6HvGTaEYrY00XeZTq+rl/tqJrrfOt2/E6JAlXhrKqfM3HqkMnHWEHjVTbqUKNR3D27aVvEVGYqyo2WN69O+UdhwYKPjFxqXCTES8El7aCzYMTqyeXt1SkXOxRAGOD9aWzjEwOv0ffMYMKycrzpbK6yjWGeKbfGGdr3pY3eYzkd9gBBPYbJDFVL5wAmiRS4njU77tYDv9bmMqqAfbu9lkKOoGsc6wPiBIholOV1UfrM5NUDF0dmDgLxOUMaTF3hMJfEb3PLNYGJcJNIMd/puVPofM3zRaHF4KHzzdIcqMGrC3sDS/hjYOr9KvZKQoF/jGKT1S+CU3U/nKdnO5iwg7ttKU4/U9UAdtp4KeMmbjcZER+AVshtW2RmvNCrMIwC3MBU9kVp0jRu8ngSXNw9M60KS70uI2XwiCUxUI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199018)(2906002)(5660300002)(8936002)(41300700001)(52536014)(8676002)(66476007)(76116006)(66446008)(66556008)(66946007)(4326008)(64756008)(83380400001)(316002)(54906003)(107886003)(110136005)(53546011)(71200400001)(966005)(7696005)(33656002)(6506007)(478600001)(86362001)(55016003)(9686003)(122000001)(38100700002)(38070700005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?K4LU5qJ9iWHSl23jrt5pc0anevMjkG4fLIbvsRTktmGBSbEce28Lo+Hdt9fd?=
 =?us-ascii?Q?6i2mJZzlp+H+ajv0Dm+ht8tYm2l0q3JhCrT6yoVwla5P7P+VkhN7bHGxtSQm?=
 =?us-ascii?Q?M1HeWlQES9yn1Lw2L09z2iE5fBwNhMreTITMSQNuOFPsrydq/fEgwr9jeHta?=
 =?us-ascii?Q?pjE5IMHCq/2186g1wLmgGbb3E1hwmGsoQFfDTNEha69qGMpRtkO9WFEyFIVG?=
 =?us-ascii?Q?UcVz+1dj1PsjEICTSZ/jpx0DD3wp2bq8C/WW7muDUGNWOssS1fB+YpuF89FK?=
 =?us-ascii?Q?vTFJzA2fUR6Hlre/v2KdvOPMwv5GkDbU9LcvDnekn1ylCrTN31B1zY+TUKOF?=
 =?us-ascii?Q?hW3Z42uf8vviSof40cYW2HifXn2F2rz2szQiYdx3hHSr+Dye2dUOjRsZoM6r?=
 =?us-ascii?Q?YXF/GIOr5LGNUoc1Vi98mmvyf3JB+1/NjwAA8sqfGKEldW/aUFc7gM2HaVfZ?=
 =?us-ascii?Q?oENnBE1gzTgCQma0F0LA+U2RXp/r74ljtX3zBxc/JFJfYwjfRta5DGWY96C8?=
 =?us-ascii?Q?SupEFph2t3V1KbIYbBnqhEbqNwsgF3b5YJgMV/nBNNsbnyumJ1Ig3F8oTnU+?=
 =?us-ascii?Q?GiHah1JdAhDUWL11kz9gd/mG7EXKlTfVSnRNDVO1GyynNRBYBBbz+pzNFaTR?=
 =?us-ascii?Q?sBnifRxJ6NbvCJAolS9rB9VjOaZFgZgyO0DkT4ItcJnY0QB3ZeyS0dnrh25H?=
 =?us-ascii?Q?6RcnPNBZL7+rpwB1OwmXaYh4eEQ/Ak6sgCVxokH7RIAjIE5+68tXP0g3pV1Y?=
 =?us-ascii?Q?yNoN5hxwyCLLBYqT6lM+fkJMTcWeYaG6rSnF5OXUMpb9wpoVwd2Kv09Gb+/v?=
 =?us-ascii?Q?LT3ApoQatwsDWbC7dOWK0Io1GfnwN0Fvt2MZqFd7f99y/21DVDiKiSGpMV5S?=
 =?us-ascii?Q?GXXzIAfhDS5AHyih1WPUmzza5tGXEN7m+dkwQuNDV8xB2UrKlauCtnPpkxXD?=
 =?us-ascii?Q?iSRFME/ge942aimC23bmnkIRPDOrtLBdXOBieWj+PMHSiW32L+uBoN4kFuqX?=
 =?us-ascii?Q?h3fK7Hy55evrFi8qv9WtOii3pNc2AApyHMUF9gxtsjASb7Rb/tkgR/eNNcZF?=
 =?us-ascii?Q?LKrYDaynh9YTotGiOydU4XsgQAEIxEe4rv7yw3uhyDemm2XbzK0zUtsNZDB4?=
 =?us-ascii?Q?IlQJ8eber9ztlLby4rwfUOKbulqw3UYLyS6l3vN3/U0s7x4d8le1FzRgQC4g?=
 =?us-ascii?Q?xcqKkbvfyPffWWlB0GAHsyq2xX13zLyJtQ+/Qd+bQP4xwxzdlUXd5QJRLMpU?=
 =?us-ascii?Q?wB4RkckcTjTg0ufv9LQbyqwlIrgRlubV/N1fxrqJDxCO8hU8AjwfEu88L+Rh?=
 =?us-ascii?Q?uVTfevVPhTXKmfVqlZP1NJJRTW2WfiLXJy335OxeLB9Fp+TbLaZpeY9lbuGs?=
 =?us-ascii?Q?zVtcsd4kzzL8XZ4yV+uj96PFdFYgnrpMNEwOvpfZxaQZxWMTfftW1gMn5yif?=
 =?us-ascii?Q?rHKvvtCHCucvmSPdRt2k2Gb+LLyCwaYIkGKHFLNDVf+li9x0+lPxmV0IJ437?=
 =?us-ascii?Q?op6/sYOvLwlhD4tEEXKa+SyNnueZJ5Ky9dcS9QvMQ+JeAFZGH1lg0ej5FTcV?=
 =?us-ascii?Q?5RRXUrov8U3KW8MR1+vS3ge/FM9r5EYWKJDeWn6Ayq9dE7PWbNHS+vvLHkEL?=
 =?us-ascii?Q?pdOMzAw2YjSobwzRqN+aHwY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b229d4e-ac7c-4b4d-6388-08db1f30ff3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 17:25:50.3340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2qrgmp7LTO1WZe+cWQboKZtMIEXBGeoV2X7c2ld45xfA9Uii/r8pCUvvaDBgeO6YRez3WipPSh6Gpky/DoB8Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7451
Subject: [virtio-dev] RE: [PATCH v3 0/2] virtio-net: Improve dev config layout

Hi Cornelia,

> -----Original Message-----
> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Monday, March 6, 2023 9:32 AM
> To: Parav Pandit <parav@nvidia.com>; mst@redhat.com; virtio-dev@lists.oas=
is-
> open.org
> Cc: virtio-comment@lists.oasis-open.org; Shahaf Shuler <shahafs@nvidia.co=
m>
> Subject: RE: [PATCH v3 0/2] virtio-net: Improve dev config layout
>=20
> On Tue, Feb 21 2023, Parav Pandit <parav@nvidia.com> wrote:
>=20
> >> From: Parav Pandit <parav@nvidia.com>
> >> Sent: Friday, February 17, 2023 10:45 AM
> >
> >> Patch summary:
> >> patch-1: consolidate read only field at one place in driver
> >> requirements
> >> patch-2: define device configuration layout before describing its fiel=
ds.
> >>
> >> changelog:
> >> v2->v3:
> >> - split into two patches
> >> - move read only description to driver requirements section
> >
> > These 2 patches are reviewed.
> > Can you please open a ballot for it?
> > Github issue:
> > https://lists.oasis-open.org/archives/virtio-dev/202302/msg00405.html
> > And the github description has the latest link this time. :)
>=20
> I think something went wrong here... the link above points to this series=
 (i.e. not
> the latest one), and so does the github issue, and therefore the ballot. =
I think we
> should withdraw the ballot?

Please withdraw.

Right link is: [1].
Please create the new ballot with link [1].

[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00556.html

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

