Return-Path: <virtio-dev-return-13331-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A51EEB64DA
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Jul 2023 15:30:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4BC682A895
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Jul 2023 15:30:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ECB59986682
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Jul 2023 15:30:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D5B4C9864A2; Mon, 10 Jul 2023 15:30:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8C41C98648C;
	Mon, 10 Jul 2023 15:30:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5S1JiK5SQT4V7mo4IHxVMjSmHjAy3114eChZVbFTjoy9B9MLIGZWUuGBgJd7uKDxGrADAWtQss8sV0bPrNfXfWgdzApCTMcD0PiG3V5UAib4N8owO20fVv05hlxGqXOWc0IMRvxvgJJS/OVLhSJmT/F3x5eCgWlMqYT0ykdUm70lG/Jbz/j1NMXiKLcGJxVvsCrWwTzy6QtNeOi2S9x0xf1Qav6z+isXEB2vu2NaoZC5mpH3lLNaFBeSwh8d3neMgWoldZe+7VLzQabqn2YixqzDWPhEOJ6ICUZGJTaC+mqwbwbLT0RIJcId5iiDWeLjmXmOZm08DJQAFtGzTb8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdsuAJrYoIsaDhvDeFnbdXgJtuXSAL17KmH5VjAGk/g=;
 b=OvIlOxoGdcOv0DLWhAQyVQ7F+Wu3g6BucSTpEawDQYKCKCEj4zWC4DeZS8k+lshvuKQ/OWOWXN3yjK65QznQPcnnW9+frxHTZ8nQ2ENtwiHkV5o823cvgJId9w6cAkt0P2QqUQRlao0iz+Ws7lCbYpMfbtB8SSGF6rlo5l83t0qoSRM0WCgTUxkB9kmq/GqzCwkdxVy64TlpZz0sG2toQT7lCo4R+NxSSPzNu27U4ANTM8Tf2CefLg3svxpX7IFMK2dxMzgslMyZO/OPPMQJ8vZ8OCYsRvykwP4awajWaUUwkPa/zxuTWSCFtQudbz3F7wZn06ZrW872Q+KtrbR5jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [virtio-dev] [PATCH v13] admin: Add group member legacy register
 access commands
Thread-Index: AQHZsOgWDJbZS5QbLUum6ujYtKcWkq+xdcMAgAGGM8CAACVmAIAAA4AA
Date: Mon, 10 Jul 2023 15:30:04 +0000
Message-ID:
 <PH0PR12MB5481A4185F544691295D5C1DDC30A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230707153019.147039-1-parav@nvidia.com>
 <20230709093550-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813BA69D6474462F413BD8DC30A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230710110511-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230710110511-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB6609:EE_
x-ms-office365-filtering-correlation-id: c74e4e89-4c63-45cc-6d67-08db815a88f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wn9udU9Rne4YiedvaPLYHTA/gKweoM+dAGRMoBbV1CAnsCcmwMyt1xkW9cmeVWcBASrZfPjHotZtOd3bHzSfTbEGfwhrazE2MjHePbzQTW7UqzBXwh62PbC4TBiuqDBBj1QmdGHGOs6/QsHacfGqiicKdnL7aMMxl3OVIx0N9k6+d3mNr7sCz3rBFre+UmlLrJ5mXKNbhtXoDc0t4WkwI6POxtIOg5qlyWdAYj+mJ6kDGqkJoV3WTcXQCpP/C12Medo0PusSjJXaAFkW9ValXphThIMW5BpJERV5GrMKeomCIcAzC0OaH96qexQpyXFOgRsLmfKR8Xcy2xR8Azfm/y4xrIxFcX4cLQlXT8uRo07t1vNdZ+z4Gbpc42DwtmzlC+EbAdD9qDSaVF2hGUpklNNFLtbt3Cr1PdMP9urt4y36HocaKFBy/ddfXOV9oqDiwq0x18bv2Js13w7SI81XoYlWNLyoIArOq7VBT7eeVQFz8aFbCHVi4RTqxhHMTLZ8V6zK13bHUpuhsTs73AdhZuH85Ed8mEMAF/2FgCP6n75QK/t+jtdqUUCBL0wfRkkEeIcEcjTkesbz2bUgVxsW7ngQKa1LdOokruo97o1BrulQwEmEOSrwxs7L9hxTcsZi
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199021)(316002)(54906003)(71200400001)(66446008)(66946007)(66556008)(66476007)(76116006)(186003)(6916009)(64756008)(7696005)(4326008)(478600001)(41300700001)(8936002)(8676002)(107886003)(5660300002)(9686003)(86362001)(6506007)(55016003)(52536014)(26005)(33656002)(83380400001)(122000001)(38070700005)(2906002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?i67Bm/fpjda5h739ElFz4Y6NQa0MhS9USSaRXVhYQZpiLA9bp3KPUSkACnlA?=
 =?us-ascii?Q?UdBwGvQXtZ4FAPbN8CXqk78VWu7WexeEQoNBLwzr6wCWPBQ7CiwHsCznDZLl?=
 =?us-ascii?Q?19cr45wzjdX3xiQsJAHvZuVJR0At6O18GDnqjx3ROS4YCmMjsz2bc8wdWYVl?=
 =?us-ascii?Q?pJ79Rs88Y4wngLHaIYS64R1FN+7DapGtE7nOvU9hulvks0Ea1unSuI1Uwuby?=
 =?us-ascii?Q?Tx9ksp//RDdurI6pJ/fKqqnDVp2jBKrBYYF9fSXgsFsO6UuxzqjuPBM6+yNh?=
 =?us-ascii?Q?RdWW012FtuWkvlyFNFzxuiV8aRuhzFj+WOdmj5kUdADftObQzWHX431jnTSh?=
 =?us-ascii?Q?7VlwDnNwN7jxLtQX5OYyze1yF87gVfvwfslQYDFPEQvBKbOaH09zi7kzh1wX?=
 =?us-ascii?Q?ovfZD5L6VA/mFLB6kBzg3huyISFwYMJcxVEAr0JxXPtAqJ3Fk99sfURMXT/U?=
 =?us-ascii?Q?Zz4+HTnuTX9a4tSH+Ph/Rjmbut3pJKI9AGX3JeTgLunVHhObsYdzThl7hkhV?=
 =?us-ascii?Q?ULdS2nq6mQOj8UXXofI19m6euIOFwAUCAWVh2A+tWPehsaSCQH0Ztm8eDSDS?=
 =?us-ascii?Q?qSMemzBl6uJDfVVXqY6p8qBJm7I10otkOEj9ZBpnK0FdUTAkAsRJJ+bU0GWK?=
 =?us-ascii?Q?OYqpRa88k3lpCUeVIV8f2fgSTuQn4u95wKqEjypsQQhmMBC5N1R/msRShWgc?=
 =?us-ascii?Q?aCYEd6z70xFdL4CCYH3TAByZxOxYVH1+lMhXKcjPeNtrmCcyCUQ2jWcFKGMg?=
 =?us-ascii?Q?JlYw9Mot/LkI7DVgSgVgUPCH6Z2FyVUDmVP5/Tp4I1BBZWd2f/+50/83xG1k?=
 =?us-ascii?Q?QBniDRFCJ3qaRdsYnm15QWShLKwXluABTnDwIw2IoKWQCjLPVIU7TGepluy7?=
 =?us-ascii?Q?KUNYMBzJYfooHkJs8I53tapHigs1ED45UrC5YZQyW+KgeOUuY7rH3i8vkYi3?=
 =?us-ascii?Q?RO94hLeBfxTcP2z5LPCdhaAl7Uqyk8uFmPeZYTwEeMc/1WkseHirYGyZTA3F?=
 =?us-ascii?Q?xpsQBlcgVrm7mE9MAj/w88YAYhcmDk6pQ+IzyY2yn1rjdz9bxJ/hCoDIqofP?=
 =?us-ascii?Q?2hpVB5Jdv6aHw9qtjEBB7EUaS2+3vE1xfODbC/zzB2WQh0XPNmiyhib2DQN1?=
 =?us-ascii?Q?6Ct9hGWh3PfNpc2C/uv3xd7+Ua8rZN8W5kUYPkoYVuWOEfzvGHMUbYpuc+4t?=
 =?us-ascii?Q?XkILfanKp8R2p4N7KJkYgC3uIfXktO/XVKV2ZNpOVb+84V8AtqADI9x5P4nZ?=
 =?us-ascii?Q?KMzOUglWmULcnOk0Pm2sqkpvML9Y18zTsmYRmF63xYfDteNUxq1DIJDgM0w3?=
 =?us-ascii?Q?PZ2yY8NbJAfTHaSwMPzWq11OFKu0FfxzvwDCEQ3JDJ7jZk6sZAH+ITKDthPd?=
 =?us-ascii?Q?j7y1+ZZKRNHcn/F9+DMuuRQLrGlAfzcNUeTvk5/JvzFSLv0DHlp7IzIFG2/J?=
 =?us-ascii?Q?1gWJCVqV25+6XpF4qfAlvNCS6o3ul8s3/0ZwaCQJm9jTwS3a9uvxrM7mVE+E?=
 =?us-ascii?Q?rFNPcHiHZVaGgLEWxkTHMv3oLLEqBdzHijFqCitfAihwIk/M3TYb8wfsLOR5?=
 =?us-ascii?Q?geXKzkcfHC6ya4xvsCM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74e4e89-4c63-45cc-6d67-08db815a88f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 15:30:04.7312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kR5JT4Ab5mZkGfIYVd6xp+0VcHa1ie2y44wjOuGCavXkG9Yn/vG+1f+4PZq3H5h5DbamleOGkiLQOVw2JQ4XJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6609
Subject: RE: [virtio-dev] [PATCH v13] admin: Add group member legacy register
 access commands



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, July 10, 2023 11:17 AM

> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Sunday, July 9, 2023 9:47 AM
> >
> >
> > > > +If within \field{struct
> > > > +virtio_admin_cmd_legacy_notify_info_result}
> > > > +returned by VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO, the
> > > > +\field{flags} value for a specific \field{struct
> > > > +virtio_pci_legacy_notify_info} entry is 0x0, the driver MUST
> > > > +ignore this entry and all the following \field{entries}.
> >
> > Please see above, it appears to me that it covers what you asked for, n=
o?
> > What is missing?
>=20
> Oh, my bad. I agree. following stresses this a bit more:
>=20
>=20
> is 0x0, then the driver MUST ignore this entry as well as all the followi=
ng
> \field{entries} until the end of the structure.
>=20
>=20
> > > The driver MUST additionally validate, for each
> > > > +entry, that \begin{itemize} \item the \field{flags} is either
> > > > +0x0,
> > > > +0x1 or 0x2 \item the \field{bar} corresponds to a valid BAR of
> > > > +either the owner or the member device, depending on the
> > > > +\field{flags} \item the \field{offset} is 2-byte aligned and
> > > > +corresponds to an address within the BAR specified by the
> > > > +\field{bar} on \field{flags} \end{itemize}, any entry which does
> > > > +not meet these constraints MUST be ignored by the driver.
> > >
> > > Wait a second.
> > > - end of list not documented - we want conformance statements
> > > - for end of list I am guessing other fields do not matter
> > > - entries after end of list also do not matter?
> >
> > I reread the above driver conformance statement.
> > It already indicates what you asked.
>=20
> So the above two do not contradict. They kind of seem to since 1st one sa=
ys
> ignore second says validate, until you look closely and see that the resu=
lt of
> validation is to ignore.
> I suggest we clarify it's other entries not each entry:
>=20
> 	MUST ignore this entry and all the following \field{entries}.
>=20
> 	Additionally, for all other entries, the driver MUST validate
> 	that \begin{itemize} \item the \field{flags} is either
> 	0x1 or 0x2  ....
Sounds good. Revising it.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

