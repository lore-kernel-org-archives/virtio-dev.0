Return-Path: <virtio-dev-return-12529-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA87CC77B75
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 20:13:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4F07016A409
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 20:13:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 48B029866C0
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 20:13:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3D6ED98408F; Wed,  3 May 2023 20:13:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2B3A89865A1;
	Wed,  3 May 2023 20:13:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfC+QNjXNvv0pUTlROMLm5MXOXd4yLEu8UGu2/OPOpCkBdDHj56TcJRFv7l32JbdLm/n6npqFxlZ+7NV7GUojZfXLs6hU4dLG3xwvZjQSipx5EjMTtooS+gyHxZIMgF6hSuWOyY2AGpMN6HhZIetQXHQbRBR4nr/vCfV6Rb0F5dj8qSHYlgzF21HBaXq3R/ah3W0l5v0ninj9Px27F2Fsi05xuupnbFCx1TNbjOX+gVabeXDPcVn3neu5qIynquzkX9qJvCEvE5td4BNEINfYq9WrSXLgeXwThMvw0IJ6WCsB0ylUwwbBiS9kJtAguKHjeOJ+V4bNUj+a3eceIe0Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BF/HX7UV7VwkWPvrdP5Gjp0TxNsspbQ5AD+7OZxjj1M=;
 b=N5roVrY4tObmHM8cGOEfmI6+nXE3+9yYFpebesnmT/z4vERgqrdZIScTmDw8kTgvnyABS6zIaz7oIZFPhg6G3sQVAFiPLwwUw2kEfUpGzDGVSL35yAlLUb4KU6u9dZXPENh/QhaMZHakgYLNS06hVvB5uUXszmT+ndzIDIrh4nHubgZRRHj2Itcj436ae6EtsVVP6OCMq7F5y02lKyUb64znqp/zVS2jD482WxJZ1Y0Z999L2kkwr0PbGOcJ6fZS808c2jMliDSKkQggtT9bpFGtsZhxRty784eIKCCFBYXzXjG/ebfImkQzRl0jhlAOCZAwbNIVG1xJvojAkcVZNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>, Maor
 Gottlieb <maorg@nvidia.com>
Thread-Topic: [virtio-dev] Re: [PATCH v1 1/2] transport-pci: Introduce legacy
 registers access commands
Thread-Index: AQHZfW80Yz+dzO+u+U23I2pKfq74J69I7h0AgAAEsoCAAAhigIAAAC5Q
Date: Wed, 3 May 2023 20:13:02 +0000
Message-ID:
 <PH0PR12MB5481DBFEAAFC8E32F656B719DC6C9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230503032659.530330-1-parav@nvidia.com>
 <20230503032659.530330-2-parav@nvidia.com>
 <20230503151908-mutt-send-email-mst@kernel.org>
 <8c9edc69-933a-9202-4495-ef60e2f93c5a@nvidia.com>
 <20230503160748-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230503160748-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB7378:EE_
x-ms-office365-filtering-correlation-id: c5f1d5bc-ef47-47a3-7e14-08db4c12cc1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 npDwpXWaahi3kOj9RxFwekTkqfVSMicRPrVG0piWba31sejY5H9pwzvmXoPbOIfD8Zx9NS7cHACgxTvN3A/Br/ogGzVbSDZ4rJkzb9xwd7wa0UJ8v2lcafL1htTM4hZho0zEuR5cTkSKMxlC1swXUhfOi0qBL1+pb5tsQ6D8bSqOaDa5FFoktgtnIAC0GkNCcsjJADWMPyYWnVYWDo2xr++1EbaB+/AAyAfXcFeHKmWPI7cPB9jELkYym5aGllPZVOs84j9oq2TZGRrspSnjUDKK94js7OPECUHPjKr9mWeVT7Q1ioTzFRlorqoD+fRdHsmj56hj9vVF/WzZ/sLOrXbYM0U8XKU3wOgaL0URNHYzPl/VjapKDX5ov89ffCITHFr0SHD9x7+NDyyRrhEpspZqumUBtjaO34a+VgT7w3Xoyx1thBqdYwVngHQr81CvOQwDvzsh2Bnc9v48oPXiPUB/DDYZNNifDy2hHrcV+xYwzbIFOME1nWPDNSLRgFQ+u9HOK3kE2YNjekc6QYyIRt7laPSugTjuEC5lLrCEIo4COXwpI4lcrkjwT7SDgURq5Fj2OXkiXyEPuhpVl5Sdng/I8CGUHbliTqRUCUXAeiXbv0EfeiRY9OGGLi55nV/n
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199021)(5660300002)(86362001)(8936002)(8676002)(76116006)(38100700002)(52536014)(316002)(66446008)(4326008)(66946007)(66476007)(41300700001)(6916009)(66556008)(122000001)(64756008)(55016003)(38070700005)(2906002)(71200400001)(7696005)(33656002)(107886003)(53546011)(83380400001)(9686003)(186003)(6506007)(26005)(54906003)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uXtDP2tpiv7qWsGbOlvHK+5RUd18DJ9p8z+nXkSXCIwb7FSKuiSWk36+pEwC?=
 =?us-ascii?Q?kt3vxk1VzwsrAUPJChE1lUE9i1JLyogwMc6Xh3b/XcVkF0JZ0TRSIz61aV4C?=
 =?us-ascii?Q?moVZuDk+pHYGGO1paSwDEuSd8tQg4XwnxoXKnUweXjRaErTiBDMtMRw6NuBV?=
 =?us-ascii?Q?umnrVLY6LWMJOwS9iF+FNmhKdexlLylo/QBXb7q5UuM2xWcNmbOonjujqor6?=
 =?us-ascii?Q?CEFtstxY8qkIIAvxUJiNBeUPpusouL0mclZFRwFF3IvwPH7G/eu+O17KYpK+?=
 =?us-ascii?Q?XNI4KbPF3RMSMJZJuklhHXD520zqDiyzG3RudwhSbP6/xAdI5gpYKVjRjcYC?=
 =?us-ascii?Q?CErcnIOHBLg6INyPZj1R1eF4ajEBSZfzBV2QqGriim/iaza5+PPSsuV+aYcV?=
 =?us-ascii?Q?hn6g5/U4vhTM6RDgmKl+b33dpzb2bw/6TJYvikT7zs+v2itI2ryPAVVjMZfu?=
 =?us-ascii?Q?LBTmjLrhjawBwCbVI2MCsFOp3BhWqmu9mK2wPZyYpz2O+vV+mhzhlwOIOsOB?=
 =?us-ascii?Q?1Gq5MTM7gDjTBVujGuPaenrh0qFi7X2bEAmPAfbxxPlHLo/Vy2n6ABNKf6ch?=
 =?us-ascii?Q?MPnCNyP8QkoHI1T1YMFqxLhDPfE0sSEoNWc5agc0K/6BEpzY1VTsB4rC6ZuG?=
 =?us-ascii?Q?4vXezCRoGDA0I6uP8ccnDOrtEohUVz0kBe9oSAFyJxuHyG5ZRvFl56al4cBc?=
 =?us-ascii?Q?BDllhKk4/HBz9+YniXvTYJ5eNKREtdADZqywW6sS64dMzdxt8vsVfiiK+6yw?=
 =?us-ascii?Q?nIJxnF1FcUegmiH3Nn58snvxmwhzabbRTOOIDNnAEGgIc79bYeq0Q/9MlXkD?=
 =?us-ascii?Q?KAc3DF2ZyuGEQdWMWo2CyqcuzbfDGdtgVGqIzH+qyqsldrDig0j1c2/hw6CC?=
 =?us-ascii?Q?vLz3MYR3RGk2rnjixqBMGrz8rJkF3H/iZJMbGeThf/4sooibOaFXefpUh2s3?=
 =?us-ascii?Q?yEBP/aPdLFqBiUsi+zP0zEaJf1Zmbcx2yeXD2QL7//tpS50tPNx+VO2t4oRy?=
 =?us-ascii?Q?OuKQRKMeQp/mwcIglr6tD12WpwklBUhMA8eWZzZUwA/5t7mJykn/lMDXzfQ5?=
 =?us-ascii?Q?VAQvtsDJ+jo3V1yHZJlNJOlJfYms0kN2zAKtkQWHP8BHUfaC879UEPdnzzE+?=
 =?us-ascii?Q?X2wGa/DDXZtoHY7IF8WDg6UmhH+Hmp3zGl1TCPUGgxibGf+m6/MS/VLxftkp?=
 =?us-ascii?Q?QoniBvUazBfwEhnDVfWsdBPITCDuDExPD9Q5LBtqmuuBCepVeLLh3DjpzYrN?=
 =?us-ascii?Q?3e7WWiVBi63dv5nYb8f2hY1npghIr6q0LtgYGzYiSX9dN9HCJHgJ8c+bIGq5?=
 =?us-ascii?Q?1VavCrFm9TQtMdXksNQShRpM5CIeE2PT8PWw/MF59aOuOOQxwePbpBUQQGrB?=
 =?us-ascii?Q?iF1mSfLfRw0EnS0C1xkfIy37QiPjsPbBJ9KWeVW8FyBVJySv0GMT+as4i7A6?=
 =?us-ascii?Q?ZhgNROyksyF0IAJ5Vt0PH4BS2VUjaQ1cQe93ju9fZKK9F0rpBrl7prLuo5bv?=
 =?us-ascii?Q?qGSCur0JBOmwv8kkzeH22w51L8GzaxNNqGFmH1sqRuCgYtrD/JdmtHQw7Uq5?=
 =?us-ascii?Q?QNyhqm8kqXImvaZ60Vk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f1d5bc-ef47-47a3-7e14-08db4c12cc1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 20:13:02.0410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2nHGpfu+xSMvN30ThhGTtC/bNYi4z0seSN2i/dqhVddcdkHWO8A8svPv8gjpUgtrbdxxmmoRtN/NIosz7dWxKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7378
Subject: RE: [virtio-dev] Re: [PATCH v1 1/2] transport-pci: Introduce legacy
 registers access commands

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, May 3, 2023 4:09 PM
>=20
> On Wed, May 03, 2023 at 03:38:31PM -0400, Parav Pandit wrote:
> >
> >
> > On 5/3/2023 3:21 PM, Michael S. Tsirkin wrote:
> > > On Wed, May 03, 2023 at 06:26:58AM +0300, Parav Pandit wrote:
> > > > +\begin{lstlisting}
> > > > +struct virtio_admin_cmd_lreg_wr_data {
> > > > +	u8 offset; /* Starting byte offset of the register(s) to write */
> > > > +	u8 size; /* Number of bytes to write into the register. */
> > > > +	u8 register[];
> > > > +};
> > >
> > > BTW if we don't have padding we could reuse buffer size and won't
> > > need size here.
> > Yes. sounds good.
> >
> > > Do we want to tweak admin command structure generally to use
> > > u8 and not le64 for command data then? WDYT?
> > >
> > yeah, cmd and result be u8 is fine.
> > If padding is needed for perf, may be that command can define the paddi=
ng.
>=20
> The commands that I defined do need u64 (much easier to work on bitmaps i=
n
> fixed size chunks), so they will use that.

You have already defined it as le64 field. See it below.
So it is not padding, the field itself is le64.
So no need to typecast it differently based on the descriptor size because =
it is always array of le64.
It behaves as padding when number of bits are < 64, but it is really not a =
(dynamic) padding.

le64 device_admin_cmd_opcodes[];

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

