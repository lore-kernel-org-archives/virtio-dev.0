Return-Path: <virtio-dev-return-13282-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA49EB64D9
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 19:07:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AB65B29FCD
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 19:07:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A51B898682A
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 19:07:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 990A298672D; Thu,  6 Jul 2023 19:07:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 82D9198672E;
	Thu,  6 Jul 2023 19:07:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyrY/vkIZCGxsca4TJ3tt4u/dDwLj8vvdWvGegKqROQDlI0WVodbahkLXG/rVlXb4PoML7b9pf1QrTrH7tdGNoJrKDwEasdjjGPndyF2KSYxqc0FiwOsbT6QPwFfDvo9pxKJWYAb8MOtkHijs018WZ39m/D6All0jwDjHSZnrIJcIyQ1rYKtKA9Q2hFYS2jeH3BQa1m2rhyHBpVbB9kzRRKSRLYycbi6Hzppr/37tjO8WZvo+lU6MNqVUJ2UchfU4UxCDW8OsoK4JHOJTrj5srsiuTSsyTNQupQ4eMfCt7sH2kMtoUobzUUIRQRn59YYRg766MTV/azAEVFkGOtCIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWNFFj9idCaTQNR/9kWdIaES3zpj8/M92PscEBeMqmY=;
 b=mfh5owBO+qpkdscPXBPIUhEGf1wHFuFvXM3O9Mha5cDmDEqpifax2D30xDctKaN2//+h1BLwbosOMH+wSx4FuCdQCD9ssSlzMRhGAvq0A5WQMFQG3XpRXDLPqxvoUEIna+eAR6JcI9bOsqm8w3qsBezIIkKFmFdMuq37Du10JMpiMFNO1wJyXIlUVnkfajd3NNol98TOQ+kq+eRFRjxI+olXbqEpCU/CspE1dzG4qMdT8QirC7is90dZOKmo3FqYpOP5eTG42kgz5tp35YZ6UJ8YNVJ1+otD1gtxF0M6h6VKnE9csrIDJjGUm5VtlKs1Ckxtc2n7EMYfaL0HRduxaQ==
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
Thread-Topic: [virtio-comment] Re: [PATCH v10 4/4] transport-pci: Introduce
 group legacy group member config region access
Thread-Index: AQHZr8EFxUk4agfAiUezeNF66UoB2q+tGNOAgAAAu8A=
Date: Thu, 6 Jul 2023 19:07:42 +0000
Message-ID:
 <PH0PR12MB5481071FC01163C48E4CA674DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230706041714.65600-1-parav@nvidia.com>
 <20230706041714.65600-5-parav@nvidia.com>
 <20230706145646-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230706145646-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH2PR12MB4038:EE_
x-ms-office365-filtering-correlation-id: add456ba-4ede-4bb6-7e18-08db7e54468c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dAyA4f+c+ACz683B94wMpKkwv5LvWL1LMkVq7e24OmNA1vamDdKiLLis/IQXJdAuwDUARlbAGR8z+iKBodoCqTCX8+LQPTpMvO++wLKCAhvqHoH8EbA6qYpVYB7np3YRXevNGFwgJMak86VkIXUoA3PmtnWaH8yEhjRyvEsIE82fThx68+oPGQiO8kHNMBCgeiVmxiQcXMbhQ5aiIulB0MEXjSLWgwT8nef/1427F1dJUo2fwUhbas/AgdVftLhx6boWmv0xHWAqCW0QAEMHmI8SN0aanxDEmjiym2Oqy7zUBbWRDLnsOJdhOm/1MsalulV9lxNA8WKKVKj0LFf2CXf33HKHFkzyNB3zqLB6l5k4fBFG5pm5UcEDypXXYVE1zArrZ5j0yxCllFrdQKX23TTOtfLjm47qzP1aL5GDB7xI9WTJhk1ue8Sdu/WCuDr0CFxoHgSShQqVG3R8FTs96ORXDmjSSLEtkuygbfT5qbMh00CBJenmhBZLqUYWAMHLwf8LNkwGiVsX3Jw/wVX2nYwzULe/k0r9ERrX70kIYc8UlR3MGfck/dbLrPcf88btML8Ttu4Yrk7LH+q0DfxIY19Uc5+k0btmgFGO7Kj+e/9Hd9mMP9VPxLa1BSpwrOox
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199021)(5660300002)(8936002)(478600001)(52536014)(8676002)(66946007)(66556008)(66476007)(76116006)(316002)(4326008)(64756008)(2906002)(41300700001)(6916009)(66446008)(54906003)(7696005)(71200400001)(107886003)(6506007)(9686003)(186003)(122000001)(83380400001)(33656002)(86362001)(38100700002)(55016003)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ViWAtuBEV5ASWLASEvtLUb10aCvjIsmZ661qo4MwYljRMW4fb8jbn3xsClTH?=
 =?us-ascii?Q?HO6nTBwzFaFD52WdSbxtTpxxs5M7e+k2XPo34CdD49Y6avAW8HQ7KxRMYGVw?=
 =?us-ascii?Q?YxMKO6hIsrJXiKJXGx15F6fcvMYBt3Iy19D7aZZFUVB16IIfcAm0WcofhToZ?=
 =?us-ascii?Q?OKh0Nisxl52aWfGBR6MxhKeVLcc0AaTbRje/L3cP2fD2+bGAkq7xlR6yMN9k?=
 =?us-ascii?Q?A2LN9xXA8CsUa0QTIo0KnGpGlsY4aOkeP3m6WF/EYWKtwFzXNiDdm0YZ7EcN?=
 =?us-ascii?Q?X2/BryvZjXfIC0SjCueNRP+nuyUDH0agL2Su7LcLNpIMVqs7KIs6GPQub4W+?=
 =?us-ascii?Q?yEiv9cLTUv2KxGg7ZRg6ll6O+ggenHjrRGXWot7Ew0PDSLyb5H0W6d2ZZS28?=
 =?us-ascii?Q?LOSwYxohdDHDK22b0TLOxrgKYt4IHwZEqR2HM06GfRZ0ogB6iXsrFK4yDnbQ?=
 =?us-ascii?Q?BRRFGoiN8WYl3f5Vf5o7jQoqdS6ZURHpNfjQ7ENNpuHtpa9eRzAeKuM/FXni?=
 =?us-ascii?Q?G0bqj8I5hI1P4aLhdKN/ErOIJF9WRxIVmuwXDURap+cbLvZdlIO6uZoOZCFy?=
 =?us-ascii?Q?nqIve/lKw2cAQhmPV0SeJDsTNdS2lHsHNNU5eet3FSqssnz+npQLqqVDt9KH?=
 =?us-ascii?Q?sH5O+qWOeCUHRvpNtRvL1TO5wiEaKvlbrN4LA2PXQhUPxbkTipXyIFLjcumK?=
 =?us-ascii?Q?hYvMw0jpzVFycjTk+oKa+paOS0GUJmwnQF/mP8k/7Mgn5vn0bJ6e0LbjGM9h?=
 =?us-ascii?Q?PEeB3awjZIZyFFDVZUnCBp2Izksre8LbDCMSGunHVyYdnA4eUVSbp/vtir37?=
 =?us-ascii?Q?puuwZ5klMe5hrMDeZlpF4lOdzrCNHBvV2ljKwbmcBscAjn1Tnd6mckYYxDVW?=
 =?us-ascii?Q?MpIzlkeTynru3v8YxYbYWKmKBn8LcfPk+fwl8DvtGEtOVhBpfrU0Fs3yoGvX?=
 =?us-ascii?Q?kqKuKHB2PGx3I6bUaJEqyh2uWycCNxHtvajrRbR0UpsRkSYQF+BiF3uEmWhJ?=
 =?us-ascii?Q?OdFXkKx0X4eJiXdVkKkKFGVNYJs2uynkQyzv7c6d67RBx03Nz7QyY7VsleA8?=
 =?us-ascii?Q?7XW7i5Hd3/4GmRVU/aXUjKNERoUayyTHuI11GVndxhQu8ZjfQ2a84PVKlklm?=
 =?us-ascii?Q?JHLB0vBtK/HUdqvo8HCKnJIPLAFDNLq6wftQ+rz0vgHTk6QbiDVoYoR74cP7?=
 =?us-ascii?Q?Hnf4Fs6IKlagLALBiiG0KgQj3eAKEApc3r84e04s6qOgYF4a29piRdE4lu56?=
 =?us-ascii?Q?fjAfW8+JDabDHj+g0vCOehRGJBwidj6TnA2AohDDuF6DwnqQD9GNE2nW6Qzc?=
 =?us-ascii?Q?C/EU1+wjL1K5/zMcEPCYTKZNp7OtrBRLZ4OHwGDHury6rj2zI2WKUDx/xMOk?=
 =?us-ascii?Q?PcB+2MdG2DZShORzW/be+6Q11IzvB+6J5H8YzTeMBWu7GMn/7maletVV/kOh?=
 =?us-ascii?Q?jNf+6qJ68gNXc/bpfiSC2wHv6TBaJ8DQfyqze6oJSO4khCUfoTVnv5wCHNHc?=
 =?us-ascii?Q?2xhlj2UXBC9kZa9R9prA9jpCaDjDdllxS2r7x6XmDqm6WY//ClbOBiRfel9F?=
 =?us-ascii?Q?GPCzJNANA5BFb0QZxX+92zrVsBM7UOtAePKASDk1QCS8Kcntm4gx7g+MPdJQ?=
 =?us-ascii?Q?ORDjtIRYp4Sxe0AhDJaE0NY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add456ba-4ede-4bb6-7e18-08db7e54468c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 19:07:42.8983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b3+6MqrdKkzVsN5m5/94mX9mCYnGcsu5pZaST1JhwmbptCuD7vSCFoRUUAoKeBsb84a16Y71tSISlksHfcyx6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v10 4/4] transport-pci: Introduce
 group legacy group member config region access

> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Michael S. Tsirkin
> Sent: Thursday, July 6, 2023 3:01 PM

> > +\begin{lstlisting}
> > +struct virtio_pci_legacy_notify_region {
> > +        u8 owner;  /* When set to 1, notification region is of the
> > +owner device */
>=20
> I propose we rename this to flags:
> 	0x0 - end of list (driver should ignore following values until end of li=
st)
> 	0x1 - owner
> 	0x2 - member
> other values - reserved
>

> and prescribe that driver ignores any reserved values.
>=20
> basically we are following how the virtio capabilities work.
>
Looks good. Will change it.

> > +The group owner device hardwires VF BAR0 to zero in the SR-IOV
> > +Extended capability.
> > +
> > +The group member device does not use PCI BAR0 in all the Virtio PCI
> > +capabilities listed in section \ref{sec:Virtio Transport Options / Vir=
tio Over
> PCI Bus / Virtio Structure PCI Capabilities}.
>=20
> Just drop this last one. How can they use it if there's no VF BAR0?
>
Hardwaring BAR0 is in BAR area of the VF.
But virtio pci capabilities without this can still report bar 0 and virtio =
capabilities.
Ofcourse, it is a broken device.
But skipping this line imply that "because VF BAR0 is hardwired", this meta=
data in pci capability must not expose it.

Why not write it extra thing instead of implying it?
We already wrote few duplicate things to make reader life easier.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

