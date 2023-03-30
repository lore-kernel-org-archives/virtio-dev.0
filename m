Return-Path: <virtio-dev-return-11858-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4654FC761A6
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 19:00:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id ADB90216A1
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 19:00:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9AFEE986585
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 19:00:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 88B6098654B; Thu, 30 Mar 2023 19:00:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7457598654C;
	Thu, 30 Mar 2023 19:00:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoWVVD3BRUKd7SCK3o4+IAlEqrLaF29PEl9iAAH53d+vqyzwxQ+lZsfHJ58WjduXEIQ/yAm1mnDnGZw5+2uhoVcnkilbIPkGuRmbOhiPYfVIOdUCU1RrXglggQt6oqiGUr8z+1Ugj28ySUWSijrXvJcxrrKvmZLFnK2/6Z0kl1ZiKp8fFXEo1qnEyzbFM+c/R5ilVInNYNaFpvM0IQOUrS49aXLy4+BWXiS1hfZru32G9EEy5N3m4S5UcFdxFnhOlcMpNRlIFgbMPuVKKfYiy+FL1ZpRM7pUhVfibAKJOjsNDS8k7LlJw15WTWHLXgfnaHEkQl8jIDtWxXUSCBMA2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7QH1tll4KqyaPtylytY8Wtss5mdgAeup0NnvSCW2SY=;
 b=ec0zLXOtQpTxNmex0QfrcjGXi4hRecvYY9/MzVGTsJi4MpuQHkd79ulWLXOafFN1A0p29rdUgUAqImyIK81uaWdHpgeJglKykBkqA3rk52U5c1rbY150VqKUw22aFRKVPvb+iFsKrhZwuFAi5MVX6+dFSTvDOXOJ6+IInX/mv9jV2lwAvGd2PbkXognV+spW18m/6Tdwxhl/xn199+Qejl/C/2vREpm3l/5GIwjXgO8T8dgYEjmOFyov/6wuxsWjwkr/gLFg8UR4MT+RwYzLkiIJ9mbp3ULeC3QGd2m/EtSCEQ36jYcaQONP94vx/xLHFRQj2RvT8YEUbOzQJPOihg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Halil Pasic <pasic@linux.ibm.com>
CC: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Jiri
 Pirko <jiri@nvidia.com>
Thread-Topic: [virtio-comment] [PATCH v10 2/8] transport-pci: Refer to the vq
 by its number
Thread-Index: AQHZYoTLE1YEPN8eX02yEOKMG5xpUK8Tj/iAgAAaVJA=
Date: Thu, 30 Mar 2023 19:00:34 +0000
Message-ID:
 <PH0PR12MB54816E90836D80B4DBB9CA45DC8E9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230329212341.465843-1-parav@nvidia.com>
	<20230329212341.465843-3-parav@nvidia.com>
 <20230330191019.5a7a10c9.pasic@linux.ibm.com>
In-Reply-To: <20230330191019.5a7a10c9.pasic@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB7023:EE_
x-ms-office365-filtering-correlation-id: e58c494f-af04-40ff-8970-08db31510ae5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 S3zhICmuvv6crL9zzTiDhzNVmKo75qBFSEsIY+DszyrWR0BCC/88HfL6foIlA2cXd7d/IZCiTXOelCoyOdf9c7oIwUHT3+NonkDshCsGivLVU/nbZ1PF2p21qdfF258uOk4COkpGYvicr531X/tGxq25z1SaWLkt2BaIMVQyBOV8VUB/mAw4bPeywl2zFRLW7DBSIpJlqtTgnhMHMZeYEnuWCa0faMosOoyUTVJnUTP9anR2DmttVjylIZcygQzlwpHFh7bDizI4xruLHCO0vz5xbDYGTSZQZiXcqf4f0gSw0rvH7JbU5BH5BQW3hh3ABzJYRmN5dvauOOuDXw11auo/CIR/oAjlcvbqqT3/RtN/inm95vjJ8x/3xIYHmtdb2h2tSt29xxwwNi5Z7f2C9rVZe4WpBkIziz7y+LbwjFI9zqvm5/UouNuJ9tgNIsGFbhJPZGOaTZ/nDxOmhBMfgfqxCJtCXi1Af3EeKkYl9p4hld0DxUitz+EIiTCyUzEDlVAMtORuuYUTA0h9UhY/yUKGZhTWFxzq36Oa5hRS+DpHRtKI8zkIfDmM7b4PIz1VzWonppaswAqgRdYxbmBERyXF+ttej+VaH1xvGqXyH/qUGeb+E1vvCKmksg+vGIQVV4N1cmO1qsocRpc4EFGE8A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199021)(38070700005)(86362001)(33656002)(2906002)(478600001)(107886003)(6506007)(71200400001)(9686003)(83380400001)(38100700002)(55016003)(66946007)(76116006)(7696005)(66446008)(66556008)(66476007)(64756008)(5660300002)(4326008)(316002)(8936002)(186003)(6916009)(8676002)(54906003)(52536014)(41300700001)(122000001)(309714004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FyR/6mHxDa2DnADDcBtAq+0XgezMMcs6d6CeN3Y9VwZoP4rhqr4+yExCil96?=
 =?us-ascii?Q?bEdEUNyUrISUK8dpFBmywfynhApsyLrp7JHLFGSF8zjv0j1QXGfqfTN0u8sm?=
 =?us-ascii?Q?8AHxe3LrrKFwHWtQjC9zczoJwhsxXg2mFvEIbvQ+CEhtEIgyev3jG7WtgQi4?=
 =?us-ascii?Q?NWujU/YFlkcF6S68Uea25jNMbgKcLslp3/UktHaZRcmzxEHtS0xda1BbX37v?=
 =?us-ascii?Q?SJJFrmRMIiOSfcAP4Go6pKLTshsN0v9LWlCm0QuW9nHI3wf1/XEjZYbJDYns?=
 =?us-ascii?Q?V4pylOMnFcPTQNphFhQs014cYn58Tg3lDK9Lt5aB+xVF8rYnPgMcuaZaZi7A?=
 =?us-ascii?Q?VRj7pkytAgIa2Ll/mr12DDPyb+CmMI6Yt7aArj0B9/XWjOnYaIynx4hqTaoy?=
 =?us-ascii?Q?HvuMINQJ4DxwxcuIhppCKFeu2imDmygOS7cLIS56RA+JOECYmAH3SZ9/lwUf?=
 =?us-ascii?Q?ltaoxclaAjr9ayNtF8EL+OIp8j6CHXsYIcHzfPUuPD6doTMjkAfpo6LKq9jp?=
 =?us-ascii?Q?i+RxLKuhooGiP0F2SZLy/dOvw4KYiEuvoGMvGpm1a7ssfyKdzXf5FF5Kb2Lg?=
 =?us-ascii?Q?tMvnI9Ayu/9DigQexsHl7/U2S5kqBdihXDInq782yYwrOy1PVpRM24D3wzMP?=
 =?us-ascii?Q?37l/GgARPdrq/62WLeo7Yqu5VEFb2X+Q6h/jItat2qObGgkP8S/lB9cM0aVa?=
 =?us-ascii?Q?ICzHj31l0uwtrk384M+jfyCCqvtryCiCa8zJ8XTYG0Ziktch7YyEcjsDyDbt?=
 =?us-ascii?Q?QEGqspPuJ/mCIU8hZLDBnv1Fntyvw/mzpeB3CI2FC/b30niXg+yr/oO2hzXA?=
 =?us-ascii?Q?8wNBnvOwEk0q0b3vs+H4IgUX3jTBL8xyc6cuW0EfS/OOp7Ygf3kNVfqIA/EO?=
 =?us-ascii?Q?ahSolbrLjIxXTLnDSMXiTW618LMa3oXTbmG3/EqoX3xQOK35L7llvT/hlzMj?=
 =?us-ascii?Q?wCYFzwujN8hg54sT9OoLRyFvgvxA5BKWZQhxcEHwDAFsfo+PEKYKgMiy8U3D?=
 =?us-ascii?Q?afT9gplOn5t/4pOCtQjbgKMIKrdUbpFt/PZKrcc5Uws4RqncIYiAbemf7qeg?=
 =?us-ascii?Q?QTwxHKz8QhdTPVjtzIGmKowwlCVfU0rE4XAUYlOaOwKthKzwTlCoaThR4S8m?=
 =?us-ascii?Q?7biYvTcqE5HZzHjhvYGFUerAHvODBco9WmJaiH1I6frZd2i7ZEgm9mYKpfv9?=
 =?us-ascii?Q?vKjc5pR0JXUWNv8u4PZhAhDazJjIiW2Wdbj+CNDgUWsAgLrvS3IPCns8Y/HI?=
 =?us-ascii?Q?MCWa99b7oyMUdyvRG6dOzXq49uuWKeHPfDsHzet/JHqbe05UIpYYZnTVTXzq?=
 =?us-ascii?Q?e0EG3xReGQ/fvOnUSJOsEsi0ijzciFS8EVdU7GGWpdCRrzK9EW4ADXKTnrVu?=
 =?us-ascii?Q?ENyqSf69gq3iU0leiM61sXS+e8NuP8RdBdQ3eLJOlkesGMYcxsgNrgcwQYe2?=
 =?us-ascii?Q?G5rCEO48PYA8seTJObHraW9WlzVdecSoMvpdulKYHlvUT+dKQKrPukTIHzVX?=
 =?us-ascii?Q?ywz00+CBNdcimrkVPShOkYCciX9jJnmKN3zpx3nUQscfe6WvWf9Sj1yoCz4T?=
 =?us-ascii?Q?diWaVziJNd8W533dt/8DG1uben0MXECxYwEHT2cLvrgGhQjWV+vCxjHXsx71?=
 =?us-ascii?Q?zdwou9IIxg1K/7W1g88nLUk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58c494f-af04-40ff-8970-08db31510ae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 19:00:34.7659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zeDnop6xsRhBp4APqQqujK4aewZrYIGqITp0prS/c5pj3kE6nuQxT2p8d8l6zffqL9CcK099L/zWidwVJt1Q9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023
Subject: [virtio-dev] RE: [virtio-comment] [PATCH v10 2/8] transport-pci: Refer to the vq
 by its number


> From: Halil Pasic <pasic@linux.ibm.com>
> Sent: Thursday, March 30, 2023 1:10 PM

> > -        The driver will use this value to put it in the 'virtqueue num=
ber' field
> > +        The driver uses this value in the field \field{vqn}
>=20
> This is one of the problems with this approach...
>=20
Instead of vqn, it is just q identifier.
Sometimes is vqn, sometimes its q config data.
Currently wording has taken care of it.
But a better field name can also do it in future.

> >          in the available buffer notification structure.
> >          See section \ref{sec:Virtio Transport Options / Virtio Over PC=
I Bus / PCI-
> specific Initialization And Device Operation / Available Buffer Notificat=
ions}.
> >          \begin{note}
> >          This field provides the device with flexibility to determine h=
ow
> virtqueues
> >          will be referred to in available buffer notifications.
> > -        In a trivial case the device can set \field{queue_notify_data}=
=3Dvqn. Some
> devices
> > +        In a trivial case the device can set
> > +        \field{queue_notify_data} to the vq number. Some devices
>=20
> ... the 'vq' number here is not the same vqn above which renders the usag=
e of
> vqn ambiguous.
>=20
Not sure I follow. It is the vqn of above case in trivial case.

> > @@ -1053,7 +1054,7 @@ \subsubsection{Available Buffer
> > Notifications}\label{sec:Virtio Transport Option  If
> VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated:
> >  \begin{itemize}
> >  \item If VIRTIO_F_NOTIFICATION_DATA has not been negotiated, the
> > driver MUST use the -\field{queue_notify_data} value instead of the vir=
tqueue
> index.
> > +\field{queue_notify_data} value instead of the vq number.
> >  \item If VIRTIO_F_NOTIFICATION_DATA has been negotiated, the driver
> > MUST set the  \field{vqn} field to the \field{queue_notify_data} value.
>=20
> And here it is really obvious: if VIRTIO_F_NOTIF_CONFIG_DATA has been
> negotiated the field \field{vqn} does not hold a virtqueue number/vq
> nuber/vqn but a device supplied identifier which may or may not be same a=
s
> the vqn.
>=20
> So we went
> from:
> if !VIRTIO_F_NOTIF_CONFIG_DATA then vqn is the virtqueue index if
> !!VIRTIO_F_NOTIF_CONFIG_DATA then vqn is queue_notify_data which may or
> may not be the same as the virtqueue index to if
> !VIRTIO_F_NOTIF_CONFIG_DATA then vqn is the vq number if
> !!VIRTIO_F_NOTIF_CONFIG_DATA then vqn is queue_notify_data which may or
> may not be the same as the vq number.
>=20
The current wording is written bit simpler than above multiple if-else. :)

> Which is my opinion less clear that what we had before. And in my opinion
> calling the very same thing virtqueue und vq number interchangeably is no=
t
> helpful either -- makes grepping harder.
>=20
> I don't see the benefit of replacing virtqueue index with virtqueue numbe=
r.
> AFAIR the supposed benefit was to:
> a) harmonize the terminology in the notifications part with the rest of t=
he spec
> b) to resolve the RSS problematic with its receive virtqueue indexes.
>=20
And also, the upcoming patches to use either one of them that uses vqn at m=
ultiple places.
And you have already voted for vqn in the new patches ballot yesterday.

> For b) we are going down a different route calling those receive queue id=
s
> (AFAIR), and for the notifications part see my comments above.
>=20
This would be done anyway regardless of picking "index" vs "number".

> I'm about to reply to the cover letter, and make my argument against
> standardizing virtqueue nuber (and in favor of standardizing on the on
> virtqueue index) along with a diff that is supposed to act as a counter p=
roposal.
> If that doesn't work I will give up and make peace with vq number and vqn=
.

I think the filed name "vqn" in the notification area can be improved.
The main reason I didn't touch it much, because CONFIG_DATA has rare usage =
in most virtualized world, real devices will not implement it.
After 2+ years of introduction in the spec, no open-source user has find it=
 useful yet.
May be some use it there.
So if there is motivation, we can rename the vqn field and further improve =
the language.

I will surely read through other proposal anyway.
Thanks for taking time into this.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

