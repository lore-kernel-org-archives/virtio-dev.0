Return-Path: <virtio-dev-return-11478-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15D1C678D5
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 14:36:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 63378776AC
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 14:36:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5B7309866CF
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 14:36:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4DB219866C2; Tue,  7 Mar 2023 14:36:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 369AC9866C3;
	Tue,  7 Mar 2023 14:36:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bal91/8WiZMV4POg9zwgxH0lTHTzTAky6//W+0CuJfV7AkeO9oNsoZaE1VNiO1pM7dKPdTNf2VJ7ouVQLfln8FDnProvsARLVzjZ+i1GnF4Sy6WYpaSTS2xCFxAEfcgUPEw8HLN7T4ushyBFNcnsCQBCJGMUDtoKYfzeDh9ewF0TyjbUICmD4dbkF3YTx07sv85hBmhWFd3hCt/M3gQNiIjuJdcxTMgd5aRkj3WSuPhIKNChCUbQgicYGuTS1cyunQ8U7UpJa9iADVOjCQ7W5uI20/qwKlBpzg0L6uL7/mcOfVVTJ1qi9qtWKqUvLGPePBOpmqLSRpNWQy7Iyvjg5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWbwgq7Qqkif75sGnyYewPY0qVcUt+mRqFtX+/QjVdU=;
 b=akkUba48WVBtkS+XvPhX83f3Q2TUk1eqjeC+SOR7kSzOAEvPUrGpyW6l4d8d0lYknbnhi48ir1YE3FDPBx+OFOdy/RX1XIarm2TiumR2eZq35IUK75pRfxxEzXN4JOQNFkhRqIkbRzyK0PvbZ/9+H04NJpBTacBdCXjfbQRjNh4PZ+spYF9LUpvzfPOTLyEEf0rT5/foC+DE3qKKQT1IwWc/vL77G4ClfA8TvJ5jJuyoPQO2ypbIvBGPTmRAYXeqULn/qxYvL+D6CADJmEZwMe7/6Z5HH1pGtdJZgc4uUMcJgAlNs7041UoOb2NF1O30wKcbzn/ve5mbAkt3n50MDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Heng Qi <hengqi@linux.alibaba.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Alvaro Karsz
	<alvaro.karsz@solid-run.com>, David Edmondson <david.edmondson@oracle.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>
Thread-Topic: [PATCH v10] virtio-net: support the virtqueue coalescing
 moderation
Thread-Index: AQHZTEeWQwTFVtCRMEet8OSrJT5oDa7niZXwgACc8YCAB0RkYA==
Date: Tue, 7 Mar 2023 14:36:40 +0000
Message-ID:
 <PH0PR12MB5481A82132513839815C525FDCB79@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230301141027.59500-1-hengqi@linux.alibaba.com>
 <PH0PR12MB548192A8443A7F30A70CFE80DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230302183149-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230302183149-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY5PR12MB6180:EE_
x-ms-office365-filtering-correlation-id: 5e614f00-fcf8-4fde-f729-08db1f195d88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 L07i0mq5HiLB/VdavBkQBTTk9nb1IZbAGSta7dMTmMPnW5XQbkcBSX4/knO6lvg37YJkrx3606O9ksqPGb9lF+swlGq0r1Su4kFCxoayBHdHCgrrTPGd8CZ3MAogUXM0XHne+rA5weqBfxP/XCgGnbXs+QCJTfaUX8QZkQW6knA1B7EZMPby+vAZ5NrQM1wT/SGXZhpl+i3ucHIMR9q9E2aeH9IO5u+9MUjmN7Aka6NXY+TZkmFTT23ZplZSGRNBtJ96YG5mVjqgzO4BPpiHIsZUH2kK9w2LHVbKdDv6HX4gcYOYUCk4XwrVDlnOLckvdTUqlcIsLUkJ0o+6Jq+gXo4EGYBn0ILfz19/OiObvCzD4aASsQthj84Y9MtmpbXlgkRcQtt4RG8AiwqED3Iqf9hZyOeepOKfeQIUVkzbC+atrpbYAVyVcnooRAB19fSJRzgF7P2zZDvcxiXOAwN7TJJp0wFJ6ViHz4dIr3Li34Fl3yEoTkMK9jTYw3GAf2a66QJR5hjLHOcoCNcvBAOBb/FevisVtNdMaxWbk4jWxlh22NV8FrAoIBPx6MWQFfcDmx8R1jfvoprd7dAUySm/QCUmCIUhANwYgM5p+ARHARQN9kpa6VJa3VglhIYVlXFiRFf10cz+FqA1NkUmb9ARArmvmj1ll/SqIRRcNXiNTEyUVTCWj7qxhBy6VzwunucjzCTdUHfgKtk3aj5myWhRgw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199018)(2906002)(38100700002)(9686003)(186003)(122000001)(55016003)(38070700005)(6506007)(5660300002)(8676002)(66446008)(66476007)(66556008)(66946007)(76116006)(6916009)(4326008)(478600001)(33656002)(52536014)(64756008)(8936002)(71200400001)(41300700001)(316002)(83380400001)(86362001)(7696005)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TU4arqeAJpqBNL817NpAdV+bDlzE6oKWOacDdwJSsbjVxcI+IJ1B4Y98lMof?=
 =?us-ascii?Q?IiXKHSlW31piBQfMYdoJfrN4OK2gt7qwXCGbRLNdB0GnqAiBhTu0C33yWaTa?=
 =?us-ascii?Q?Agf+Iuo0g4sFNQ5a2M/r3W4ISU59bhYsX/N3JGO8H6DOWMqCJJKFRiHWSRVI?=
 =?us-ascii?Q?FPnCx6TmX7hAoTLwlOnIImjA0GeKIsXFVRKjbeqBmPkquZ4Wf98154eUk/B4?=
 =?us-ascii?Q?dfC+rMBn48T0uRqXCoqc1EpfkIeS/IMckfTfrrSp/uUPacXStzjNhG8aA18f?=
 =?us-ascii?Q?CCGFhLKFNlFZGRMxKVSmE0Qnod74NeMlxtET/1+3BMnBARho4RlGrJItJQQW?=
 =?us-ascii?Q?XcqshCcS55T30X93Zp0o6gbIb+ngyj6QwaVU/tj47j2CLYD7yyCt5c+ZuFcP?=
 =?us-ascii?Q?HtZ6kT40SBBwIOtYK5oJpS8PfBUYnM4K1ieYgd1XOsnSKzTuTvcVdxxDayp8?=
 =?us-ascii?Q?tgd8vruA2b/hJnH128S80kqsOUhYeIF7/Y+DZl6y7UiRVn6uDJ+1Boc8VM69?=
 =?us-ascii?Q?TWmXFn7c0c/bg7llgO9/1LYMCYu5e0ir8K0KHtoM5HaFBbPFK6LGQGNIFFXE?=
 =?us-ascii?Q?fwHi3AH9HYunIYSYQA6dX9jMTO0/agaXDWXH//MieRxBHA2hHQEYWtqqp8TV?=
 =?us-ascii?Q?bcPnDStOjmzEc4objJM1KOasYtg8YCAJz1wO/0qk6SteH70V52bNWpqiFtLa?=
 =?us-ascii?Q?6aRNgI4QR1GMAWE2fhwHPlCSra+inFQLcb797sGaCmtg19gAILFlWGTZUjeH?=
 =?us-ascii?Q?kP9hzR7g+vanTFQP/AMX0DdcDnTUYxn29EiKv10LEDIVd6Fu/v60WM+80S0g?=
 =?us-ascii?Q?Re2P3ko6/hu6gTToEj6Y86/lFho2BnDRff0GXAJe5nZPtSDN533eVZgKQZQi?=
 =?us-ascii?Q?4pfvI/uNKkt3OSUYjfE9jcawmq3jcV48a247X1q9T2W6M0zhWGqVecBaLOHJ?=
 =?us-ascii?Q?BGJEdeROcuIWBURzlUW3v8Fq9CVqCIBAwKkIhki8WnO6fgSMOev3bElOWF+C?=
 =?us-ascii?Q?27O6xa/yWu7LHtFg8jYLpyteAyqRUGyWj1bu1j6TWhv51gxfNrj0E/gqIE1v?=
 =?us-ascii?Q?sWchau2faNUwa4vgGKS224NJP1nlrz6v5lqKpFSgW43GS+nCvPlG520e7vBb?=
 =?us-ascii?Q?55QUwvpgCaEqseb69MCLzQKOYzFwVWKBbXkv/ldL0CuX+dXR9Hhx40EFyb1a?=
 =?us-ascii?Q?07glXcnK0HVlDEEt9Fv/sPwfFREHG58J1mr1qzZRvxSVkQ1BVpJBzMIEQcbt?=
 =?us-ascii?Q?l25rHp+b6ZhpwQ9mbQJP5LhnVpZHPLarnzWCcSwbogA/aFGzCRS24+2M/GrK?=
 =?us-ascii?Q?J6vwt505rTx92oCzmu/XwLp5KXT+iyjnks08nCLsG6xLUc2a9qTkPs8F2dBO?=
 =?us-ascii?Q?a3sp5N33ypUH8zmiJiwuqpn4R5OMw2a7c9mPyfSa6ij2COLP+1MDFpSBMxIN?=
 =?us-ascii?Q?dm7/uNzMIGNVe7iojBqnreXwqpiLTxxWJxSUBxcVqosQeuf+S3AeJnSSAf3z?=
 =?us-ascii?Q?CWPeU3NFcBP4YHbh0QMklBnfzAn0LmzZzUMp/XBJ6ljwZsn8K6sCgFHSBLB+?=
 =?us-ascii?Q?TSoB2bmCQY+2G5MlX51yPmwkVzmW6knqYVvNsPyEc1hPwvkVXS6TPW3tfuBt?=
 =?us-ascii?Q?QKikMoR8mT8ipY8+eyxFmSQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e614f00-fcf8-4fde-f729-08db1f195d88
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 14:36:40.6787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aI6brsB1zmyX0cQX2Yhv7Zj153KKQblHMceMeAki3fGdOzLN5ccpWPfsRCYOe/B3GY0pCOo+Usu0qVD/bblwag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180
Subject: [virtio-dev] RE: [PATCH v10] virtio-net: support the virtqueue coalescing
 moderation



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, March 2, 2023 6:35 PM
> > > +\begin{itemize}
> > > +\item For commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
> > > VIRTIO_NET_CTRL_NOTF_COAL_RX_SET, \field{max_usecs}
> > > +      and \field{max_packets} are write-only for a driver.
> > > +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET,
> > > +\field{vqn},
> > > \field{reserved}, \field{max_usecs}
> > > +      and \field{max_packets} are write-only for a driver.
> > > +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET,
> \field{vqn}
> > > and \field{reserved} are write-only
> > > +      for a driver, and, \field{max_usecs} and \field{max_packets}
> > > + are read-only
> > > for the driver.
> > > +\end{itemize}
> > > +
> > Maybe I missed the conversation while I was sick.
> > I remember we discussed that instead of mentioning each individual fiel=
d,
> better to describe the whole structure being read-only or write-only.
>=20
> we can't, for GET part is RO part is WO.
>=20
I am talking about the struct virtio_net_ctrl_coal.
This is RO for GET and WO for SET.
The text above can say struct virtio_net_ctrl_coal is RO or WO without diss=
ecting its individual fields.

> > > +\begin{note}
> > > +The behavior of the device in response to these commands is best-eff=
ort:
> > > +the device may generate notifications more or less frequently than
> specified.
> > > +\end{note}
> > > +
> > Michael,
> > Why this should be a note? Shouldn't it be a normative line in the devi=
ce
> requirements?
>=20
> the second part with
> "may" should be upper case and used in a normative section, true.
> We can also have a note with the best-effort part, just avoid "may".
>=20
Ok. In that case, just the normative line is good enough, as it avoids dupl=
ication.

Sorry for the late response, as returning back from travel and sickness.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

