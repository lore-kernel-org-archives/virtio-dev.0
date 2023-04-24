Return-Path: <virtio-dev-return-12380-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC2BC7618E
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:46:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4981D2AF80
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:46:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3D7AD9866B2
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:46:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2DE9398642D; Mon, 24 Apr 2023 16:46:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F1140986724;
	Mon, 24 Apr 2023 16:46:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSG/mbW0q9emW/RdUVSKExUVBVQVuFGbfIYK5cvEO6eR6IegqK68xwsIXHlt8ag8II9P7EFlKYYje9VfGgOHSjVygx3mIPbnW/HxP+VkadkcE7fL21VImWlJWfXDWN05SusOx7h8Jy99DkIxmtlm/Qi5UmzAso7amHRxe7jCRMLx1jNXMk6qoJ9UDXz6gXFvbHy0aLhjN7jAz9XsAPLqF2hFjntG6w3eop3LffrGb3GVzXGbYEaLt/5p6XiXTfnRZsmTFy87WDfF4mfvnTjgXcXFdzfSxESHzAOK4YdY541sN6/Ym/K3b8j6UFBbdzwSVGtbow7RfVHqiS1JpxR0tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUR0QUKLOfPZU4Nte8uksiozu4RsNEcbz7evFrllm/E=;
 b=kdKZ2x4Rw0ECgtJHnDIZoLBrnC7Ep96QmUq9E1isTOOZDyGtHS6OGts+dJjgWf7hlf1u/7vHhJxhD89f97T3tegDpH4ZPva7xzb/a1AH+/raxHE7dqvTgQJcbDH9I/c57wrtaa2iA64EW5wPs4WIY7pKtPmF/Cj4K+pY/kR3q9fpISSMQpNjCIgQ/xlSbrpvyiTPf5lHyZ7P0HnKv5qxtfi0yfl8V1+ZKjcKdbZLL0jsZDl3HbvKcgbdPkXTGyIsEtaDV9MoSU7lIv/eYJDYLW//q1reak3x6B5O8M5i/Mk1jg9TFRoqBWAW6Vxl5yjjTiNjAvuT2WR5/cvxuCjZzA==
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
Thread-Topic: [virtio] Re: [virtio-comment] RE: [PATCH v11 02/10] admin:
 introduce device group and related concepts
Thread-Index: AQHZZj1ver1WHL1zXEuTGOdXvhU8YK8dpx4AgAbrtgCAADTm4IAV//CAgAAAWCA=
Date: Mon, 24 Apr 2023 16:45:27 +0000
Message-ID:
 <PH0PR12MB5481083BCC4480E3303BA601DC679@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1680533760.git.mst@redhat.com>
 <f83a6a225a28909eea927575b6783c0fe238fdbd.1680533760.git.mst@redhat.com>
 <ce6437c5-0cb6-f1a9-d978-b8084c95c552@nvidia.com>
 <20230410092304-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548178169DF16AED534395EEDC959@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230424122858-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230424122858-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW6PR12MB8949:EE_
x-ms-office365-filtering-correlation-id: c97bb53d-c1ad-4004-7bdf-08db44e34eb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AWQbzOLRsCxKAmgb2hWCMpem9SBoM6neSOR15Solz5GyWX7Jrt7wVQ+lXwNxOMwEB9+IxxRNjNZg68f7UjbcrlrebEXpXtM0Q8nfBsmptUuyLawFaZcypRGOF8vr4Ufb2VTr7wt30uRE2vV0goE1SAbLAUwK/HJVuPSGqv0XYghQV0/dNpZVjTp28p8z0BjVbmG4+3SOJyhoxeKVhzsJ9g2Ltd+RIwko5emsd90NKq0sk5hK7kFxAcJyctshQiTW2QW340/Wzt5s9OX5jfLNQjGItWeldwq1hegz7tHI7ifIi+a3s2IliytpO/Dwu4M27oOiKdsebryeCOtopJzOM+F43fMIwVjPqpqfJ2kEGbWt1J4NiZKEFQIURq73CZQxnp21hVROvwAr1XlES04PnWcJcZzEyjP4n6a+aSG9sFwB3WRSpRD5Ek6ZmMdvlLtwDVSqEayKRigDpaFIXR03xrYDM1mrSp65u9ImLqs4Al4dm+SJnR5V1q2yIrLRLocxx0A3UX1rVMgnrrt/PrsNOTpRxhAK43XBCSfKuodNV/ZYmZ5GsJ/6VjmdzCp3cpmvcr/16U3rmPL8AwT0VWGbmG3N8GyqUeP7+TMzANguYZg/x9Oq3kQLYItDSo6a1wov
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199021)(76116006)(7696005)(64756008)(66446008)(66556008)(66476007)(66946007)(71200400001)(6916009)(2906002)(6506007)(8936002)(55016003)(186003)(8676002)(41300700001)(26005)(9686003)(5660300002)(316002)(7416002)(33656002)(52536014)(107886003)(38070700005)(86362001)(54906003)(38100700002)(122000001)(4326008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3L237yihCL82h55sP60F6O3DCvFIicSP9wKT7CkRmxcL1FufcD5DXEyOLk25?=
 =?us-ascii?Q?bdvxraqU67KUlTr8JlidYNF66N4GoR9SVPMtODq8YwdLK7xPdhTnTClcwrTQ?=
 =?us-ascii?Q?uxF9MQgRO6BY20VJiZgEM/iRE8rjj0M2MTrIy/VHzj5UtbVah9QjmmaQRKNW?=
 =?us-ascii?Q?94fzcVJsl8wAn450frCFUK8aQguu+5cOk3LCN8ksMgcQzTpeBy6VY0QVrsSf?=
 =?us-ascii?Q?+AGE8AYqeU4QJmuYP+IHiJW4HV/R2jz0Ugs/RY8IR9uotf56ujGHaQyKn+tK?=
 =?us-ascii?Q?7c9CA/+6KV5kht/xD4vhcpkrrkD/l0F+4z3/00ek2uVlxJVvdk/j5dYfDx9S?=
 =?us-ascii?Q?1Cx2vdfy2Nv1WIhNhf0xCdpmzxeZamgz/UhXbrvgHqLQZMdsi5oVbbNUOgG1?=
 =?us-ascii?Q?l6DoapCBhPQHdEFW6Lig8ugjtNVrAHomrZuQ+BIwXq6uz4bwu/A/S3qXxGdq?=
 =?us-ascii?Q?Zp+BaMRM77eqMv556eo8Uuj9EkfvjrGrX3CioF7565mk7ACBB9zUAguNQF2E?=
 =?us-ascii?Q?3aoTWjzp6sVuXbEcZ4T2p/JK90aVDYQQFESuKiLQxc6mAZuz/euevfqcLFw6?=
 =?us-ascii?Q?l9sUzC8gVVz/7z2G+hOib318Qi5Z/S213CSQzSAZsaIQN5OkLnv1yA6Un5d7?=
 =?us-ascii?Q?cAwUceBlDvENheAiynrOcXR14+lv/Mcj8aGRpnmxCTI3a+fyX+S0StsM520d?=
 =?us-ascii?Q?EvmDINUWJDJHSSfej0y1/9HDqEW3quO5gHP/ZGdwPFEgUiOeQQpGBHU6NQv2?=
 =?us-ascii?Q?eJ2qs6MBxF3pCK/53VMydsirBhimtj41L9027tEiuSL+ICgtchd5Rqejfy3l?=
 =?us-ascii?Q?uW6ihu00V0wJnxgsqsXdtXaQTRGlb0U6zE5h6mn5c7ri9VENmFHIpES9amt0?=
 =?us-ascii?Q?lpbCpTQYcMYkpf66B21pMn75FZyyg6zonHFVztGh67sOhMmD/EFoHobc4fjm?=
 =?us-ascii?Q?CIZuybW7Tts77jGRRxKm9p/7+MWc24Dl6aUWB1EANVCWnXETUK94lkN+KODE?=
 =?us-ascii?Q?rbug78zV9YKv1PFGPqrgazwVMSmtPxwNqlP9vlMfson7zO0NJCfBPswRsYwW?=
 =?us-ascii?Q?UcpWN5gVb4FJSFFp/MuT5PtDIw547D0N7eb/iuYpjGk7XtlyXp58KSyEesPH?=
 =?us-ascii?Q?SWUGYpeOCAhftsh3GIz3Ig6rZLIpVv2YeNlA92gwVLVd6eM3qdt95dt/gRlO?=
 =?us-ascii?Q?efbEIpvah66xqa8EyS2tLLbBrT93vFm20N4jk5unUxU3kAQpqyjpw4gYS4BZ?=
 =?us-ascii?Q?e7+aa4x1MHWJo2o7AvVykgQyGQSR1XUTZogZi586zw1WRzsOW+xxVNqQA/g7?=
 =?us-ascii?Q?Zsp1OnTNnK1ZhLnq937X2XckgtPmmRvHYQF+uDe9oOA10YbVrPmauJbzNdJj?=
 =?us-ascii?Q?qesiHbqxc8TZEuDw0w+Vj2rr4zR8Yq0opNWo/lDKWVelKY/9B2i0r+Xyd3wk?=
 =?us-ascii?Q?SR6k9fAxmVUKiGuXnbL8j6wQuOpEBy9kQouSS8cZqiAJ7nJsOun3xXAaBBiI?=
 =?us-ascii?Q?NdA8kgIhX5Q/WW/pSsq+rbPVjsIqyxs/Zf0Q4kcwXFQu2HMEzdAVWic8tYz4?=
 =?us-ascii?Q?8r6kgjbY3jJ8w1aPzeI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c97bb53d-c1ad-4004-7bdf-08db44e34eb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 16:45:27.1808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 41L8hMZpQLBTHV5GhgoMKPi8eJ2MZ7Bym63LXqLNxYr6d+swZLZQwBb9UcWFy2Jly/ksIAAPFOqnuYUXDmt9fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8949
Subject: [virtio-dev] RE: [virtio] Re: [virtio-comment] RE: [PATCH v11 02/10] admin:
 introduce device group and related concepts


> From: virtio@lists.oasis-open.org <virtio@lists.oasis-open.org> On Behalf=
 Of
> Michael S. Tsirkin
>=20
> On Mon, Apr 10, 2023 at 04:42:42PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Monday, April 10, 2023 9:24 AM
> >
> > > > From this point onward you can add,
> > > > --- line. So that it doesnt go to the commit log.
> > >
> > > I can but motivation for design choices is a good thing to have in
> > > the commit log.
> > >
> > Yes.
> > Righting it as
> > Usually, I see those design notes or rationale written as third person
> sentences.
> >
> > Also, since those design choices are good to capture, can we start cove=
r letter
> commit also, which usually give a complete or broad view of the design?
>=20
> too much beaurocracy really imho.
>=20
Commit log is capturing the use case and other design aspects of the spec.
I don't see it as bureaucracy.

You didn't get the answer when _CONFIG_DATA question arises in past.
You also didn't get answer from other Intel engineer, which was unreachable=
, I forgot the issue.
Cover letter will capture those.

If we prefer to not have cover letter, please move these details in the ind=
ividual patch.
Anyways you send out v12 so next work.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

