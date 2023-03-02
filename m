Return-Path: <virtio-dev-return-11386-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104A8C6FA8E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 18:40:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 730E075987
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 18:40:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6C3959867AF
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 18:40:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5C97E986799; Thu,  2 Mar 2023 18:40:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4840D9866A9;
	Thu,  2 Mar 2023 18:39:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L42rwoxlxXN4V4wizbsDgpEdJP5X3j9uQLH2wbA+0yjq9xFrI0gtpJTsPS/k7rlUFUyMXmS6owast/qWWeuPDwF4zx3brbpjtIhwFKu4dV0sO1SMAHHaU32xvTY25PXZQNADfnqnStcmXbnjt2ofMXqoVi1fTkv1mWNErSbpyNGuMzTjRbc2V0CSAo3tuN2euFEDI43JVDxUkizRIxkU7buUo45FOiObHfM35F2EaWcff8/LRiUp2uG41OeTs/zLF5V/vLexkOfrLsTArRmOeYzGGgyaovQws8ptNES5hCYWv5gpR1pI48005QQQnSBFO9NVi3cXQh2qLg6fe09ynA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UQkLiZ1b+/krrZrqQyRVmEf9Kd8X1X2n+bA2SeWgzw=;
 b=B0P4NaDvCIGKkeVDBzZQ5ddUFmF2hbA2e9805vWSrAJZg2306VLTGm+LsKn2kQiQF22AHp9pTwCoKdgkR/yQdgTNrHG73sjdgYo1DNQ4izvKSwBwGl8l1elKzm8D1rQj2nSJoD7hF8gnqpbI8Ma9PSUqQAcNfrL/19FRIcnCwVUOu39/0beio6zIHs/B6miR/KQPao8fL8dkPtzByN2pYjnZKPpVE/b/uiy/8HmwiOOYuHWNNO9LZON5Jx11HoQ2JLOAtvBDMD3la89EkOsQPiS5vpbUwJSNXyh6hkXCLckFXkP7dIRLKPIM1QeOrIPWaIaWaJ0uROOriieUk07ktA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com"
	<nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>
CC: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan
	<lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf
 Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [PATCH v10 02/10] admin: introduce device group and related
 concepts
Thread-Index: AQHZTQedCbndgUtIakOiwG8aTcmX467nyKkw
Date: Thu, 2 Mar 2023 18:39:47 +0000
Message-ID:
 <PH0PR12MB5481AF533A3C9FC0EFEB46DDDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1677761896.git.mst@redhat.com>
 <2d232eba17d75c5dad2db17dc297f34a3612c33e.1677761896.git.mst@redhat.com>
In-Reply-To:
 <2d232eba17d75c5dad2db17dc297f34a3612c33e.1677761896.git.mst@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB6929:EE_
x-ms-office365-filtering-correlation-id: 226a06b8-7ea6-49cd-4aa7-08db1b4d7ff0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fsD3tCX/bUH4ZLsqt2mtS2JQoF30MZk0YQIhheQS5+PRSmhWoR2yrHgF0xJpKHWlSFL8K7ZikNIbZLVfmY1D+66qUpJtj8xr5pLsGqGOsiIgHKvm8VhjXLNZFe3AUs7RK5+kjTdYtuXcLEXffgtN4RN0fIG9Ox1tiCrbiMCg9Z/irTFrezCRQzbrYw0j/CzgcgZ3AmQzXgBE+f1Jy/3At2iv2oBfyfE3swzs/KK3Vzz8S/8NM+FyDa3FqGuKIGkxJsNRlNvvU4K+N8rMhYvYH2BreaVJd6Fcjc6qNMCPPlz9D0j08zyZi6x/SSlp78fJtrM+TZG/2vhqNOD9x9Pb1OINc6cSZoFhtJ0/3iY4tbX/sM5m9kUcT/QE8mnD2Rs8CdhqiNR8lLlREals5hy6CYGy7J69NulFN4iLHQ3qbRf6SG0SMDeE4xgDQi0TAJKpV+u/CGyssDKCZfV/yhRBVmhZG/aTMmWlifqcyncGSEyu4mfa0JP1Ql7gyaM4vCDhMtj9J5PUY+B0kh+5muGQGLBI7cCy5E2wi6uCs9oKNr2IxPDn/6xVZ8DQE5Pk3zMSf0EStWkdwfBOViBk1JioEQmw7oa0vHf90pQ0k91GHp9cjpMWJZICAFIysDHx3MLYhvCEQnm2s4IphPdDs9mY9rNR2ZfDCjTHOMjnrBP9oml9i77EHAH2P/YEx6c3RXSwIV/s6EA5ZkAQtPL+o8bLf/U0Dbn3v4sao+bCqUv4olv+phJtpb2pEvKAeuq6/TWLVnKlqfj1agrZAJxiVCTQpA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199018)(66556008)(83380400001)(107886003)(38100700002)(122000001)(71200400001)(478600001)(7416002)(52536014)(8936002)(5660300002)(921005)(33656002)(55016003)(66476007)(86362001)(38070700005)(26005)(8676002)(186003)(9686003)(966005)(66446008)(66946007)(7696005)(76116006)(4326008)(2906002)(64756008)(316002)(6506007)(41300700001)(54906003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vyikogjkOhtMAmSjTpVS/Lli4lFo6g4t2kinV3OpeP4JlcVsMtoSGdVse26Z?=
 =?us-ascii?Q?oPnOVA4MwJz7I0s2RtZhRevJ/PTiML3kvgsDCCneV1ytG44ccwRoWc1EbGrY?=
 =?us-ascii?Q?VRiP8P4C9UDgLE9z2Fa3kq6780Elq6QM15XbIohmCWgCUypmyx0LqPxDc6Ol?=
 =?us-ascii?Q?woyhcGhsA16JYckJ5afwiGGxCpCjetx8VjEAPSqYXrggJCoaB2dEXo5HB0Ak?=
 =?us-ascii?Q?olYuoM364Xuas8qn3448yAHkO00TZcB+mrJj5UTBr30zYe+YdA8QIT90Wq4D?=
 =?us-ascii?Q?Do3PRjO1rhQ8uP3bscYgxprO2+t+Nrty3JzltKzynOwa1zAbvQ0K7u6U397K?=
 =?us-ascii?Q?kNsNhBQt4FMvexh0VJKeGqdgrXQjn0MsT0YU0XF5ja4ra1ORNz3ChGSJ+q/L?=
 =?us-ascii?Q?R/jET5GFJ3+EHKDoo/Rc79fktQiAeU9stx7lfYnNcADxnb/o16PonEQHvlf4?=
 =?us-ascii?Q?ID/EBXXd3PAcDTLMDn6/MRnN5EHCYvWTz5lonh6T/dwMuIltqSJw4hBBR8mY?=
 =?us-ascii?Q?7rTLyuPmEwkUi+DUNpkGxe23udtIh4O5ILgahOPvwh1HcVhK/hWMhf2Uy8Dc?=
 =?us-ascii?Q?WnQ5C1XMFq452zneq6M5iJiW+Nkch5TS3ehl2zwGNcBeACfQOq3Tl/IDnU1e?=
 =?us-ascii?Q?nuaGrrP5WTozU0aLX2jglrZriU+zTuvS+nF6U06gXA8CLjr7qQUX8vAA6wsA?=
 =?us-ascii?Q?pIapT7/a31/HQSODXQ9UZCzU5OVUVNgCA3x0kh9K7Sxnwgt/qH6QeK/oYXoV?=
 =?us-ascii?Q?7oG4TD55Y5Adu7BUtCWv22S9i6ODeUosKreD6Y2HaZb4sJ47aopiYSbFWLrl?=
 =?us-ascii?Q?Z8IeIZjNEn8OLnEF4uKFMwIPSjdsnUD+tXwM4Mo04L9sv2ALvgRRQqQ9/S6n?=
 =?us-ascii?Q?C6oZCWW3e1tFPFGq2YyWZfVttMUvmvQ9A9nNmeLJocGjXg1DIrkQX3aQ80tG?=
 =?us-ascii?Q?BrurblIHHnD1vkL3Bz+pmFqp+7ET2HpuaQiJagACXfeXFbt+oDMmuW0iuYJ8?=
 =?us-ascii?Q?SWJ7uZoEls62KjQZWyWJAl2VPLuSeZjrH8Zgo5J1jRYBBjal7rOzRov7Dmyx?=
 =?us-ascii?Q?NbIcVtpElcC+ihTAR3RjOsbT6RMDPq7eIM0x1t0sfaT4pKmbFbZ2eJ6l9GLp?=
 =?us-ascii?Q?O/wYMdkoQT3tVgkDbhkIkjknxUGU7bYGcGHHlUBDl5wCXdKiIDl9LjKVMorZ?=
 =?us-ascii?Q?EN8RR/Whhk9Ut5xKkn4MbhK2CqyTaguseGiS/GNqKGv101FGW42vTPiyw1hN?=
 =?us-ascii?Q?C867zwGREXhquptQsOUzS5yGLK+t/3RQBRkW81htJQURR33b2rmWH3hTTeOc?=
 =?us-ascii?Q?LU79mJU2Sx4F8R9SwQFqtbiJjBtZNFh1XGthOBaT7ie+syzbvnPjmqHVcRg+?=
 =?us-ascii?Q?nc8VmW+a/hPGfjkLlY6v7xRJvR6aAjaCW6lADgK9aLRiBcIk9HJuyr4KAEUW?=
 =?us-ascii?Q?nrK47TxY6GV6Ef231s6WXJ4Npa22njhYKzjOcEujqEcucMTObkYlZ16PL2CC?=
 =?us-ascii?Q?Z62UqGIX4TxcxUKExlJup171lv67zC+8pmaw+ZztzA+9XqKj5TxYrFBPSznE?=
 =?us-ascii?Q?O58BjqimyclTXKrcoPM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 226a06b8-7ea6-49cd-4aa7-08db1b4d7ff0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 18:39:47.5474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XIE+6IxgREVKb3zZZj0FqKALJMzK4UmpQOKrV6Q1IhR2Hx/o2hYbpb0wxDW1PwcAbY6orKGwmkARGBfFw77+eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6929
Subject: [virtio-dev] RE: [PATCH v10 02/10] admin: introduce device group and related
 concepts

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, March 2, 2023 8:05 AM
>=20
> Each device group has a type. For now, define one initial group:
>=20
> SR-IOV type - PCI SR-IOV virtual functions (VFs) of a given PCI SR-IOV ph=
ysical
> function (PF). This group may contain zero or more virtio devices accordi=
ng to
> NumVFs configured.
>=20
> Each device within a group has a unique identifier. This identifier is th=
e group
> member identifier.
>=20
> Note: one can argue both ways whether the new device group handling
> functionality (this and following patches) is closer to a new device type=
 or a
> new transport type.
>=20
> However, I expect that we will add more features in the near future. To
> facilitate this as much as possible of the text is located in the new adm=
in
> chapter.
>=20
> I did my best to minimize transport-specific text.
>=20
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  admin.tex   | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  content.tex |  2 ++
>  2 files changed, 51 insertions(+)
>  create mode 100644 admin.tex
>=20
You missed addressing the comments of [1].
Can you please fix them?

[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00235.html

> diff --git a/admin.tex b/admin.tex
> new file mode 100644
> index 0000000..3dc47be
> --- /dev/null
> +++ b/admin.tex
> @@ -0,0 +1,49 @@
> +\section{Device groups}\label{sec:Basic Facilities of a Virtio Device /
> +Device groups}
> +
> +It is occasionally useful to have a device control a group of other
> +devices. Terminology used in such cases:
> +
> +\begin{description}
> +\item[Device group]
> +        or just group, includes zero or more devices.
> +\item[Owner device]
> +        or owner, the device controlling the group.
> +\item[Member device]
> +        a device within a group. The owner device itself is not
> +	a member of the group.
> +\item[Member identifier]
> +        each member has this identifier, unique within the group
> +	and used to address it through the owner device.
> +\item[Group type identifier]
> +	specifies what kind of member devices there are in a
> +	group, how is the member identifier is interpreted
> +	and what kind of control the owner has.
> +	A given owner can control a single group of a given type,
> +	thus the type and the owner together identify the group.
> +	\footnote{Even though some group types only support
> +			specific transports, group type identifiers
> +			are global rather than transport-specific -
> +			we don't expect a flood of new group types.}
> \end{description}
> +
> +The following group types, and their identifiers, are currently specifie=
d):
> +\begin{description}
> +\item[SR-IOV group type (0x1)]
> +This device group has a PCI Single Root I/O Virtualization
> +(SR-IOV) physical function (PF) device as the owner and includes all
> +its SR-IOV virtual functions (VFs) as members (see
> +\hyperref[intro:PCIe]{[PCIe]}).
> +
> +The PF device itself is not a member of the group.
> +
> +The group type identifier for this group is 0x1.
> +
> +A member identifier for this group can have a value from 0x1 to 0xFFFF
> +and equals the SR-IOV VF number of the member device (see
> +\hyperref[intro:PCIe]{[PCIe]}).
> +
> +Both owner and member devices for this group type use the Virtio PCI
> +transport (see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus})=
.
> +\end{description}
> +
> +
> diff --git a/content.tex b/content.tex
> index 0c2d917..ffe45c4 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -491,6 +491,8 @@ \section{Exporting Objects}\label{sec:Basic Facilitie=
s of
> a Virtio Device / Expo  types. It is RECOMMENDED that devices generate
> version 4  UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
>=20
> +\input{admin.tex}
> +
>  \chapter{General Initialization And Device Operation}\label{sec:General
> Initialization And Device Operation}
>=20
>  We start with an overview of device initialization, then expand on the
> --
> MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

