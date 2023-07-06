Return-Path: <virtio-dev-return-13285-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A771EB64DC
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 20:21:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 92FB72ACA4
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 20:21:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8408198681C
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 20:21:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 75E26983B4A; Thu,  6 Jul 2023 20:21:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 58BC79867B6;
	Thu,  6 Jul 2023 20:21:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XE0cQ4WIlsGGi94qsi4L3zpHecMa+/KD9xJTHUFm2LQGWkGn9rBkS14u/hI20YuJw3IRUoUX9GJS05ubHaMceG6XH0OYMGrTSZxbnKHeuJCyAPDrgE15p4wLbhq/esypYOrTPsZ/3ndAYDfVx7hxen1msqDnySGUOMvlNIcZ48bsd3e4iCfH3IQARj37V8fdi6josrJ3wptQt8sR4m5pC66/bMlXlXzk7erQQEcZhnhyhOSdg3JtTkO5hJUi50bW3zIQF1DEJE9pA95Jij+RXP731MPZMdG03CkWukDv22zQNZe+qcI9GbjpmogtwE6Wlh9C8wg48amGyC9X1K7HPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPPyceN42Ng9cy6hpA9/Etot77YVn7fyG/J9cNgwXZY=;
 b=SBlCRLgH1MK5nhtNJuh2Da6KKHDDEUUoiwk4EADtc8DvpgsSkSq/Imm3tWRwBZj52ZAxybiAlNAp91NY2FT2bLJRRwIrWuclH0RGnhDQZjAFe8xo33qaUDfz50wffAJLoGCEFH4MY8yhkpSiHkkMHmiWxWt2sCdxEJtNBWtnzx+BeEoYTcbfh41tYeutifpBGC6rKwYYwCI++bG8SUHtRM84J7mSB6sCkOkFrD/bcXcHht2uV673aGNTAGetmRcXpVElxjbDPXzzT1tXjLXagrzFA7QKx6nomuxsm9juYXtxi9K0HKaa4mTwsUIQdDlKrWYfojaVcd+1xEes2UVR6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Cornelia Huck <cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access
Thread-Index:
 AQHZr8EFxUk4agfAiUezeNF66UoB2q+s7j+AgAAAMsCAAAOkgIAAA7AwgAAKzQCAAACqYIAACE2AgAAAimCAAAs8AIAAAGiwgAAB8QCAAABNUIAADKSAgAAJwvA=
Date: Thu, 6 Jul 2023 20:21:13 +0000
Message-ID:
 <PH0PR12MB5481AF3000FFDBA2CBA5D7ADDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230706123954-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817D2E9B0D7C5FE9EA2B0EDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706132638-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813564E839C71709DCBDEFDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706135858-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B845ED0FDA919B822941DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706144427-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817A61E0062B9BF3401836DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706145538-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481074A79C630384382CB20DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706154002-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230706154002-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH0PR12MB5332:EE_
x-ms-office365-filtering-correlation-id: 6579ab60-6c7e-44fc-d104-08db7e5e8bae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lzFw61xHFRuLt12px2CAtzzSWCJTPJW4B9gMVcx1BsO4h2noA5sHDK2+UYeCUFo9V3b4ezAiOvMNzKifOZ1CYd9GSbGpQKrldDNywyTql+fzeyOyLqOKkv5eCaqKj10gr3lD+igfiOee1/YnL+cpH9QWbSx983Fx6+4MKk65O/00nWdFlPQSGS/NMwuHkH2iJD2ErS416Ai5sRn7M5MwviqriQPTcjlgD04SQf3OtSP3HAa5k6UT+nAXe8P1J1Ikx1/cMjQE1aoOS3by3gpw0hytmH6FJmn2F42b2NYMSY2yAwk6M16CxnyGBDAZT7CcsS+V+DWZ9oQbIfXMmqpZDEqsQ1vkWzTsrOWGjhjbDEjssFDbzRGIVUcW00E1v8jVlR07GI17/V32qmfDJqtgfaAIc2YsPbJphRJD7tO8zQM3x7Uso6sUPXczGcZnjI5W7tj5XotLyK5WwGnmQkW0DJieewsdo6sXC0nJfGX/ReFCG8o5hNqTrZYN6schhboxeSBb7GaIKv6rTcP3MrNiaaeh9UzHwP8mF9PlJKbNrDN5sfOjw2iyt+M5KvW8dXiDRWV+by804MNyFJg7F9tywKunqNQQehU7pHVeTOLJ9Mmh971Fvkw7BNEhT6YZtFil
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199021)(4744005)(2906002)(41300700001)(52536014)(5660300002)(38070700005)(8676002)(8936002)(33656002)(55016003)(86362001)(186003)(107886003)(71200400001)(478600001)(66476007)(6506007)(9686003)(122000001)(6916009)(64756008)(66446008)(4326008)(66946007)(66556008)(76116006)(316002)(7696005)(38100700002)(83380400001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?toKIVlydHH8eJ9gb4fXjRpiI5Qaexcu10rupgbec0LVAXFJOnpR4HMU0SFqk?=
 =?us-ascii?Q?Fv75v5st6mqfjiJn3DKcw7nEe5TWyqGCTNj0TKDcrxwmFE5RGF2uvevLo4EA?=
 =?us-ascii?Q?tX7AnSsQBCw+nmHH3nhG4gS35aQOjadEuCas/LQUXnyHKKeoOBUhyk2qtl+h?=
 =?us-ascii?Q?iM1cuqOtu2qmJAQPl5rU9vToQ4IEFGdyJQIKkY0cqgwaVFxPooUDK2CmvHD+?=
 =?us-ascii?Q?okluq7TuD2KwtlYmz+Jp5P3FAlSCrhgAqNpv9d+JShRei4jMzj9GbusSvILT?=
 =?us-ascii?Q?HMDDMZ3awWzproKC53t1cuIyhh4vJHyav8G9Rx1NYmRuH/K75uO4vpsGvZHc?=
 =?us-ascii?Q?QTe2AZKpam15kn1ezyzxP3jG02c5ddhzI2WuEMLBJWFQvzSt9T8RdH7rrh57?=
 =?us-ascii?Q?EvB9d4s7TqrM7K2DJ/G4TN1fswsFNEEQib9pQ02RGCNfNLM4/FYZPTc1PgbI?=
 =?us-ascii?Q?0HkcJK3TY6X6+MedsEnwGBjV1InPa0thvO+kV/AEmlA6ntywcGy0tbXy25yR?=
 =?us-ascii?Q?6rQ0tkagRarzSjXS6HOiaWYJTHLWV2ZiqqFxqNxKo4CwSHt0/jDqT3Osfv/t?=
 =?us-ascii?Q?/s080vl/5Ifa3la7ImPcT4aAb+qIQljIsnotdues5WUXsZRrpWqMvmYiJeps?=
 =?us-ascii?Q?H6NipHF61oRooDExAa8lM7zCmOV4TCk3snH84nXbSNq97tILm5amO7woP+oT?=
 =?us-ascii?Q?ErX/fI67G+UpBwbroqtXIdCepRPeenTAapO3bRCmuxH9PmgwsURkienZ3n9I?=
 =?us-ascii?Q?B2BDv5LQUc1Ugivq1inHTewZCnTFn1+5LMQz6x4Rmu/LorZY49WmsrPUYblS?=
 =?us-ascii?Q?dvTxybLxw6GDiD6zgAqdGJTc6AKbjY7UtRFPVHsck3cDjGIPCkCpD7rhzLzg?=
 =?us-ascii?Q?MTUWBozhSMyyH14XFrKpcHITp8Btqoz8vza+/ZsnY55FYlaONfYwjmFAf7Gl?=
 =?us-ascii?Q?v45DmApvHm8QY946gFvGzKCkIqb+vUVslfiEbdrmWrngydW/aNIE+8RRyCk6?=
 =?us-ascii?Q?vg2TzLT20ipLanMjFHHezqZanSBuX8dcfmszj18YYsfzE91D82aC2/sduzru?=
 =?us-ascii?Q?d8t4DfGAiVolJO2MaS/bz1C/nLx7hLCPXWG8D2h3/V7GX3rwDOLCTSKWEvvM?=
 =?us-ascii?Q?lCqo8xFFNKKL2qKvP3/SWoZbVeoYpGviJRPnZ9s/h3Nuw+cEtucj9lc1tN5q?=
 =?us-ascii?Q?ORjzJzO3Wa4x2r5qiDLAbylvL4qCvBDsR/ZhYo13BkxljGIPClpDgN5BeHya?=
 =?us-ascii?Q?mkityKUGrgWrXnRXafzTzfx671silexpw2I7O8DEq4ErsXBjueDYbGHZSbN1?=
 =?us-ascii?Q?BgEnhOg5YEkwRCJs6HSECxv9XXpDAXJfQLKwSEgv0vGRDIRH6KSMLyjC2tPL?=
 =?us-ascii?Q?f9L+S+9xe0/3rpKk7BSe4h5K3KivK62k0m4t9quZekXngrBeH3vag6Jf3/jg?=
 =?us-ascii?Q?lgTd0LAsAo4iG0Z/PPCO8FUV1+7vMjRaM4wZmD0ZiVn2kroKeb7/XeqvwYSD?=
 =?us-ascii?Q?8+azrzuGS3UI38OF5Xed4sMD0YrV1IFBm21/o7IHqciLwAAghXT/JAlH+TPD?=
 =?us-ascii?Q?rmcfN3Pad+Gc3bZnytpYzB4WlrYsYD22li7ReyGFQpsVJYZxo7d/ZjUiugBD?=
 =?us-ascii?Q?CywKRyCMAl7tp+x1SwVMB6I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6579ab60-6c7e-44fc-d104-08db7e5e8bae
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 20:21:13.7994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GGYzDdAGvEpjbkJdkBaFADw0o1ikjWTbRLDfwITWN6V46ayFJK3Pq874ITTZuHt7B020241c/ATHeQVe4u6uLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5332
Subject: [virtio-dev] RE: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, July 6, 2023 3:43 PM

> > > As the order is there anyway, why not just prescribe entries are used=
 in
> order?
> >
> > I don't see any value in defining any order. It is an array of entries =
not a priority
> list.
>=20
> I think we are losing out. For example I can see how access through membe=
r
> would be preferable for ordering reasons.
> However device might still allow access through PF for cases where driver=
 can't
> access VF.
>=20
So a driver can choose say I prefer order over accessibility over VF, so it=
 choose PF.
Device doesn't have the knowledge anyway whether driver can/cannot access t=
he VF.
So, device's preference vs driver's preference may be different.

> But I don't see any configs where leaving this to the driver's discretion=
 is
> preferable. If you see one let me know.

In doesn't need to be config.
It is the environment that chooses which is preferred by the driver.
For example preference of accessibility over ordering.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

