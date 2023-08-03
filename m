Return-Path: <virtio-dev-return-13452-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05FDC001DF
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 13:16:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 127B87598E
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 13:16:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0C54E98685A
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 13:16:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F34849866DD; Thu,  3 Aug 2023 13:16:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DF3079866C4;
	Thu,  3 Aug 2023 13:16:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJ5CQCaEsr2S4iT/Ae0HH26lQi1VMNkNfOZtCUhbux6yQolrhTJ/PEoVdPaoyJKEboQww+67cbU39x7zraN0Wqfdoaj2iKjAPo+OdAw227coISr0QHFIahFdjY91lNwbWFhYi95AfKLHbMvl+9cKFarawhbGuAkeV4jny5mxVcU5/3CWe9wLFfJkW75TkvOcMfN83dQumECoriIOo0tOkyIz0NZqVMm0fKBrDNmo+OXcwWI2mDCjX7p3LlCb4l+qIimilBrdRO4VZ4u09kjhA7vhZZwIISdGG8YT+KWWc3KbiqrcNp+QUvJ/z/aUpVWkoySAzTx9I16hI6PBDNs43w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cjBZLJecVUlva/TfWZRxYjgjw8b5xEI5hF15dd5Jrw=;
 b=KGfvnIuIsHkFtAjb1kBfUlltwKt991FAyFUHvRV2OFjhXdkEEsTW1eIK/x2h7tIkcXSWIP3Vqpsz5zFZhvTSrgjr23cvAyDenmyq/nHM4eg1HzMmBtYvXk/bJzd2uD6DJ55TrzF10pa+8wf45Du7qdud/HZMlkUSf8nnOzzt7LyIaKC3zM56o+4G1o3PJ+bEquQwu9mSj7wdntDhs8s2vlWQ3dZZU+uUOqZ2Q4qPbOA319+tSVwfbzZCcqp8+3Zr4dEhqU1wLEVuil83pWOHZqt1aalEo+gKkePJZ6CFRfFH0Xei2qbspBm8GpbkmZrxjrw1YbucIGVScqdgn3+IyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Thread-Topic: [virtio-comment] RE: RE: RE: RE: [RFC] virtio-net: support
 access and control the member devices
Thread-Index:
 AQHZxeT2Q5D2+syVdECqHrje6hzlHq/YUmCAgAAS74CAAAGPkIAAAc8AgAACoHCAAAFdAIAAAN7QgAACXwCAAAH+cIAAASWAgAAY2vA=
Date: Thu, 3 Aug 2023 13:15:59 +0000
Message-ID:
 <PH0PR12MB5481C3CE21016385BF7D6FF0DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230803083150.46745-1-xuanzhuo@linux.alibaba.com>
 <20230803054333-mutt-send-email-mst@kernel.org>
 <1691059929.235804-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481B5B3C5366CCACB221083DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691060652.3764465-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548191AE225B08BACFC0C350DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691061508.9066079-5-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481CB7BE555F4672394A6ECDC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062204.2378864-7-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481E104793F9E68E1DC95CADC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062877.0013635-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1691062877.0013635-8-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB6784:EE_
x-ms-office365-filtering-correlation-id: b70d2ab1-5ead-42ae-4c0e-08db9423c76a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rkhIJP3ET6my7SL+lWlrg4bfncvo+xtVuGwk1kQzFCQRD3sGU1avWELEXwMLXZcLR9B6JtJ9px6dWcIo0H898AHs3jaomEOZtpVSY79ujXjmjsZ6Gl1ufuwN/1U7PbYjLRwa8WoV8d0steC+jHOuMLpZ96Qy8oG/yZjKaZJEVp580+1RpqXuTN1fOcwE/L+u2zGNzGJo39+/slK/bEfstnhdhGC5MCtFSlN9k+UNj6yJukVr/YuEZJvk+SsxelIfuYw8aOM2MT6RKyyDzTvN0UfT4LunjKJuG/WDvQEX2proZFY4QTi1lNfxjtOMAwI0WW03NK93h9P0V46GL7Mi2Jn5Okk4JHLgdKvOoYRYm2hOviGLWRCpEoLb4DIFDj4GZVn4Bbr/qCFbqovx0qoS8QW2q328GBU2jjB1eLi+xR4t5nYF6EG9Rmm3yxW0Goy0WgI+j733t0nXRWDT2ddDcJSu2ULPu+jBdGgk45nonrwY/MyfqiZ5tvJPO4W2MgS3Ycnd2xpCPj+2TmibRv6n3SjnVaSNpoMvNmPWeniM9zDMJfLJF/aYqNN0Jq4RQTB7thPGLotXKyMahCahjNLKNhLYWwGCyHj1hZOUgOBlVGGS0e8u1SYoZgl6ipCGi8hO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199021)(478600001)(2906002)(76116006)(66946007)(64756008)(66446008)(66556008)(66476007)(55016003)(71200400001)(7696005)(83380400001)(86362001)(122000001)(6916009)(54906003)(186003)(26005)(38070700005)(6506007)(33656002)(9686003)(4326008)(38100700002)(8936002)(41300700001)(52536014)(5660300002)(8676002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ehSLbHdzdsqyZStIm6ZYyY+KfHKDAml41JNNceYCl1KQKMfW13mXZxSm4pav?=
 =?us-ascii?Q?McPudDl74UaMAplQEvM4YIjFalf/zHfgaAWOYgORpV8bw90zyt2Vt13Fvlm1?=
 =?us-ascii?Q?ivRxbEQ3HKYfIYFXKxvS+gth56gclgdPFJ3K82WSTzZ++Afs6af1VuWoxdVs?=
 =?us-ascii?Q?tZ83pVnMQ73eK9iqAo/8UTKQQmAWwiJQT9uvnxvRQZn3T4N0nuqGqVZk9T1v?=
 =?us-ascii?Q?AdZtmCKDw9pgPGUV08Dedn6rR7kFzcxsQYeVmADt21ea1/WfCTvT6YdEGW3g?=
 =?us-ascii?Q?RPVJfJLOCEDOVUMy7peVFP1S++Xdzx+ltQtTWB5dFkPBRvvr1E5IcFZNq/2b?=
 =?us-ascii?Q?YSINkh3ekIGMJ/ad+hN6kqxH6ktf52Ossh9vSxAMF7DAVSw+kxWxuKYU5JnK?=
 =?us-ascii?Q?7VgOUC4S2iP+/OBO1wDK+YwzOvxiSCZVuX9N5TKM/W34pdzt72Nu2k+pvKJu?=
 =?us-ascii?Q?hU9OAonVR3lWQa7o4HheoruFhqBIRrcQCuQbQhq+Gr6gLzTwl1cSQmU2dLAj?=
 =?us-ascii?Q?+Ea3zxGfUSfHjeE+QiBMjeMycBKt3wfh78ZvPQtxgx26hRp1yeaeq75Qu3ZT?=
 =?us-ascii?Q?7T6xMuBxxvTN3FXiXD02cf71TpnvstzrXSjqNFbq02B58EKOEqL+xTx3U78S?=
 =?us-ascii?Q?PE8hGbn1bmHUIddI8P9lEQDGqoG6Xh9RZ59GkRQcie2YsoV8d5nU2By4m9b0?=
 =?us-ascii?Q?GLAkZmJrLcv9y0y8VOd1QLsS2WWXpziqikOXZ/81WS2SJ30o27hmJykDV1c7?=
 =?us-ascii?Q?lTery7ExyNdYJqeV4guSnM3aoB4tE8XqQB7Te1bvYpi5VfDD+QWF3jrbaWW6?=
 =?us-ascii?Q?XcOWT6wkuuv/4wL9GMfWoyG1WDoejDPt+dpwD+1J98Nn1cRb6jq+fZKVozLs?=
 =?us-ascii?Q?1gx2p4BSMuZeayYThA03SRqH2tGSFb2nIDGP9kQWsilAPkrIOkXPgIDLM/NR?=
 =?us-ascii?Q?Z10ggUnF4H0JVbspMN+fFNxnVARkPdwVz1UuK/Lj29U6ntNWXgC/5Kb7FtB0?=
 =?us-ascii?Q?HPGXiGD9CYYe5J7TADLG8fhcSfA+852rZQAQ4uXPdDfBX14xrHkh/z+JHU/N?=
 =?us-ascii?Q?RSVI3gQ9Z+pO8YP5XdCy5Yg9ghl+r1e7TAz083B0UNMBni21LTzY1JLYV37u?=
 =?us-ascii?Q?5yl+9ZZqeBein+gcPmbLN1GW29x03mLa+L4PHTwGPMvo7rQpsOE9OulfE8A4?=
 =?us-ascii?Q?47LzTb/ewnkImWawaa0Z7itljMgA6lREcQsYn0LEcAjlL4ALcguEZGVsrOPh?=
 =?us-ascii?Q?NMmXN84gyuKsOTIH6gfUQezYK0z9XAMdDKZXhlK9gFvFJKaFU0giZOOmPtMX?=
 =?us-ascii?Q?VeJQe2JnfEwHxztx1H+0ljVlYSnOL7tbsuK5UbW5MGEyaqCtxbzBqM4be+Tx?=
 =?us-ascii?Q?xsg3aC+m6Jx6M6BXjCfwTwWIbzEw2rxjqkZLDmSXeZjEiXAs3XotFy/lxVcY?=
 =?us-ascii?Q?SIOp8aekMIcEoy8NqAHcu1I7ZU6gDyMXWunrBfEIcDSMUeAhUR27jGmNHZ6y?=
 =?us-ascii?Q?I6mXXIhmqxOclyDAsWR0hnY9SWGPCql+qaCmY1PYj9Geoi5ZsjImrQ/PSbYn?=
 =?us-ascii?Q?1SaTAJwoVIMVGIajGOg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70d2ab1-5ead-42ae-4c0e-08db9423c76a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 13:15:59.3086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hmoxSncyYtQucFYimrxgDUh1+LPLV6eqwHEhjcUMuzFntJE1xyg3C5i+XnlYR9w6TL7OsVJOX1mc1O4kJ2JCZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6784
Subject: [virtio-dev] RE: [virtio-comment] RE: RE: RE: RE: [RFC] virtio-net: support access
 and control the member devices



> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Thursday, August 3, 2023 5:11 PM
>=20
> On Thu, 3 Aug 2023 11:39:20 +0000, Parav Pandit <parav@nvidia.com> wrote:
> >
> > > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Sent: Thursday, August 3, 2023 5:00 PM
> >
> >
> > > > Admin command is what is suitable for device management, including
> > > features and configspace fields setup.
> > >
> > > I agree.
> > >
> > > But some configuration such as mac, ip(eswitch rule) for vfs that
> > > are suitable for the admin queue?
> > Mac, why not.
>=20
> Mac is the concept of the virtio-net.
> How do abstract it? Or a admin queue command
> VIRTIO_ADMIN_CMD_NET_MAC_SET?
>=20
I don't think we should abstract it.
A one command that can set one or multiple fields of the config space is fi=
ne.

> >
> > Eswith rules should be programmed through the flow vq, that we are work=
ing
> with Heng, Satananda and David.
>=20
> I know you are doing for the n-tuple receive flow filters.
>=20
> Here I mean we want to limit the ip of the VF. In the cloud case, the vm =
is
> untrust, we should force the vm that it just can use the specified ip.
>
That is fine,=20
 It is just that the flow filter commands may be different for ingress and =
egress direction of the VF.
The command that we are adding does not have concept of switch ports, becau=
se there is no switch.

For eswitch case, you would define more commands that will have switch port=
s...

> Then can we configure the ip of the vfs via the admin queue?

It should be through the flow filter queue so that it can be performant lik=
e nic tx/rxq which has dedicated role.
For switch use case command formats or fields needs extension.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

