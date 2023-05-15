Return-Path: <virtio-dev-return-12703-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D2CC77B7D
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 20:56:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BA84EF90EE
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 20:56:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A38A49865D5
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 20:56:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8C99B986510; Mon, 15 May 2023 20:56:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 785D298650F;
	Mon, 15 May 2023 20:56:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCGnVgep9B1LCdtDwbnIIRAoBhM3yMsGtfMQJjqzhPrrb3adqgsUwtXnR5UN7nmwzWCEZX7HdabaXSqLuHtW2KPJPZvQ0PzWHpYedGs5DjYS/88sydUQalAFL+gbVQ/1gU8sUGU2nca8Ap2Hw2OVVsBol3koR+1JHILUisvlXDVwlalypr+oTjUii3arQ0ts2WebP+/jJpcwH87h0E0NO98H0HfLPbWO4xCC842k+jQ6/WYf4qLfGugc8Hq/uRn2pQtIGw+UGougFXUmFlWWGP/NtmKlmL1Qg64bMCcmZGauzsTJvBmKEhBKAfHPEqYBzNj563rvSaL23m4icH3cug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrFJljxlJiE/tgIIrDA4DT/WPY6lmN5kwdK47wS8MI4=;
 b=OkL8qBv1GZCRhaGg0LDr1CgYAUt797O/WoutllqySWdpnKnNazUupw7MZyVTogZbc9VZ3LXLWw0gSEB/S700lJU72wSNUr4aeqTSqnIr0pchpleqZGLWX+ZoxUDpzntobJMiZE52xoscvklSdWi/QkVipxMglLN1pta6QRuLOOlYoRsJ8nq6LxzMKn3xYri+vuvxl6DO1jFuSV0Y6cFe33UQm5Pl7Ee1w/h68tPKD+rNf0kqT0Hgpe6kzhiuHMug2DTIG0Ec8bFHURNvikKTV7L05dBkiQMko4sDNGK8mSgyQ5VuC3AZEC+KsY8/bQNSJ/QM7hWb6sbzdnPt2H0nuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] Re: [PATCH v2 0/2] transport-pci: Introduce
 legacy registers access using AQ
Thread-Index: AQHZf637tzEcVLD5bUyVf2EjaUYU3K9OhmIAgAIV4oCACzxPgIAAAMrg
Date: Mon, 15 May 2023 20:56:42 +0000
Message-ID:
 <PH0PR12MB5481CDAD2698E8078BFFA4DFDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230506000135.628899-1-parav@nvidia.com>
 <20230507050146-mutt-send-email-mst@kernel.org>
 <71d65eb3-c025-9287-0157-81e1d05574d1@nvidia.com>
 <20230515155212-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230515155212-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BY5PR12MB4886:EE_
x-ms-office365-filtering-correlation-id: 00d4c295-a7aa-4f4c-c38e-08db5586e33b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zENoKURvdpi0Zl8IeLMCxjLPuBxRYhA4WP7Nk3+1RN2oQhjBP3CSe29UTNlGlMomiOD9RAd636d7QTMNBJ/xt1O4aujIUuNj9lNyqarboWdqXWzs5tvkQQl/3J4QIcX3JzKwfFOsm2ypvxQgVcw/qJ9Ao1wM6E6UhRnPVqYziF2fVk8Hho8HfFhP2OeYIxacbGw5BdkW9sHu7wna3ygMOaOplSgNkTbrEXqxVpTjgp2P3mJSwKlE2O+zADsxtWtN0hwzn9Zzu3R0KDc2vB4e44kcSka7d++YsA3isLgzyofdIRBLZEMD8eK2lrS34YkQi1prpvviXmz6RrZfAhLewDMiKCYqH3EUYWQxrnNPytOW39GE+Un7F8JZE5EPu7TiiXm9/HJYJXYwakLaIPFRxzmhx+LX2gTh/P638G9xOSHbx/mPrjMdAieYCG9SpfXFWKc2IQwOIss1MLrosF6iIWqXM7uVCnRiKOEDRRLDewYETaGuy5VZuNWVZCEPPMDC4BUF0fCOryFcwyf7t6/ptKi734CNXtRKwddVaOwPnZVHUyVUgnmf370IJ4rrMpahC3STtAah0Kw22vIlevqWsCpmvnVqdCTHw6vZsebeupZ83E/fX2N9IwFhrCzpHC464GFDQE1PM3bX+ia62c6Lpsxdz/23ADKKilGsm9MnH5LVqHBevmqPyaMZid6pei4rOnF66NSrto8Zc8JXkOqYkQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199021)(83380400001)(66476007)(66556008)(64756008)(66946007)(9686003)(66446008)(76116006)(55016003)(7696005)(6506007)(966005)(107886003)(478600001)(54906003)(71200400001)(186003)(52536014)(8676002)(86362001)(8936002)(5660300002)(33656002)(2906002)(41300700001)(38070700005)(4326008)(6916009)(316002)(38100700002)(122000001)(84970400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5UWowwrA54cx6Arxlb0RTqfRSKSNVJP7yUNv/Q8lBvPo3GB/xmORkn3LYWRv?=
 =?us-ascii?Q?CBLKFdadu2I2kGu5HgJ+sPIIEfhJLXdgvNRsjQWJBn+RQAtojsV1s0npXYDd?=
 =?us-ascii?Q?0XJQaPKxU+Kzc5n7FGvKVX+VfUNy9746WZP/TR63KA/tlfn7yM64NcQPt2HF?=
 =?us-ascii?Q?LzQ8BZVbxhc20WtFOAVuFLLsbpy9gA8RWguy85uZoVF1r3Pwa5J97p5YS/Ec?=
 =?us-ascii?Q?YlSZwglSWaSAeIVUb5fKJva6OHGuLAq8SuNHMxV3wR+jjNIEUP078Znkohri?=
 =?us-ascii?Q?PzGMui9cFzuKi9n6+n+t9JrRroKbFFKHMTUXHMXY2uzsf8YwBCY917+UhaIZ?=
 =?us-ascii?Q?NebauvsTCHq2RjG7TyOWmfFDnvutqitzjipJEshTGFiXrohudvQcIOC5wNcA?=
 =?us-ascii?Q?0CGmNT5H+sQSZTEzg7DS1UEITIil5ZCzIKqA5TaY2wXqJQdZbU6O/3i4XXGv?=
 =?us-ascii?Q?4SWJE4rk7gCXM3aeu455XHGRMv12qZP4dPMJgKJdhDDF6MXG2QT4nzE58xXm?=
 =?us-ascii?Q?bUnCJKpqB2zdClHmZ81w9geZZFQBJCyDqDFGh3fw4TZtAoJN9yhJJurJgypl?=
 =?us-ascii?Q?8W4oUtdNzfsuGVWdXetIq081t8egwbgrfk8gvu1PqLfB9djvH2rUQ8uqjs1I?=
 =?us-ascii?Q?7bCcul6bCOJdclfVUcNxl4llES0d5QfIbWNrebyFyJoCfsLp0p9Kpj9DHn1P?=
 =?us-ascii?Q?Ud0rPfyzEkPURH5OxDemU7cFOTVaDr6j+ObTLLZq3eiH6HaskAbT/13/VD8U?=
 =?us-ascii?Q?H4aHCeNTXpOuHSCF1NF5ZH64x2eC/z/Q2fWWKydnssRPIxPPrTWsI71vs0Bv?=
 =?us-ascii?Q?a5nTvZiJDMH/HWYyxbEJR6ePIXGD7G3bIKHE1E7lb4TEeby3uS3uWXGkejeR?=
 =?us-ascii?Q?PFPNjcDo/zStaXkQsAsm36iVVaS4njMMij56PH5o5uxWjb8VlfffncGpIyHV?=
 =?us-ascii?Q?s0zrzyDUqmp0vyCTi6yiKX/nhQ9uTXLerqMBhsAXzDN+FfpUp6x7UNi8pXb3?=
 =?us-ascii?Q?HIsFO3E8tLGiUlFmWmZsXJfu3yUC4oq0PK2Fek0nLj6kNK+abzFE7YkQJYx8?=
 =?us-ascii?Q?MPS+ySp+qyR6Tgf+tuQnVEaRyf7Iu8ZThtXpjfcGfjcOqdJf0JKEAk7yXdc6?=
 =?us-ascii?Q?hQ6ND48sTfAVgBUU0esp2nHdbvvSqETRe8w6wqn+J4ccWP2m7ByugyEj1HAJ?=
 =?us-ascii?Q?23o/1BdvgGPVj9mfzgYCwf9ugoYqN5zxl4bCvAwGVyGJ+VjcQWRBhSPZSP7y?=
 =?us-ascii?Q?30j6CPeAbcbGR8yEOKoF57o8F9Z4uSpFRi/ZoRSpNlBL96L3ilanP1denLal?=
 =?us-ascii?Q?uZdXwAAXwvkyyHqlQb1+sPr0zULTWUu8uM09cCII/FcffS/yY/JCiDQhUN+c?=
 =?us-ascii?Q?0KmbXuvq8HB5UilqKsiTPhTPw5bZo1mnO+TDL2xHLQDUTMKnO7y88sdgNQwR?=
 =?us-ascii?Q?CO+nFBzr1fWcsCGrk8XcdMmG6dAVPYiiR28LrA9hISr36hY+2DibmEZiBicO?=
 =?us-ascii?Q?sJac6BeINtpPEXlIAB9RxK0BWoTGC+fun3w6lMPSMmbYAjN1Z7rznV2V8nbw?=
 =?us-ascii?Q?ay7D6nfJXmfQpaI1Uk++CgX1fZYdtEuSyMyvbJXOAZV5aUATNere6v1Hx9Cw?=
 =?us-ascii?Q?TuSjTtYvsC+ttZJml+8JN6Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d4c295-a7aa-4f4c-c38e-08db5586e33b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 20:56:42.9026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rnpSeUsL6GsWJ+PizHaaRxepAo/fwiEOdVXIeDuzWbM3Ncyxn/cZhT9WrzvxRvuO41ZNHcJLQfWypVmpe0KaqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4886
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v2 0/2] transport-pci: Introduce
 legacy registers access using AQ



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, May 15, 2023 4:30 PM
> >
> > I am not sure if this is a real issue. Because even the legacy guests
> > have msix enabled by default. In theory yes, it can fall back to intx.
>=20
> Well. I feel we should be closer to being sure it's not an issue if we ar=
e going to
> ignore it.
> some actual data here:
>=20
> Even linux only enabled MSI-X in 2009.
> Of course, other guests took longer. E.g.
> a quick google search gave me this for some bsd variant (2017):
> https://twitter.com/dragonflybsd/status/834494984229421057
>=20
> Many guests have tunables to disable msix. Why?
> E.g. BSD keeps maintaining it at
>      hw.virtio.pci.disable_msix
> not a real use-case and you know 100% no guests have set this to work aro=
und
> some bug e.g. in bsd MSI-X core?  How can you be sure?
>=20
>=20
>=20
> intx is used when guests run out of legacy interrupts, these setups are n=
ot hard
> to create at all: just constrain the number of vCPUs while creating lots =
of
> devices.
>=20
>=20
> I could go on.
>=20
>=20
>=20
> > There are few options.
> > 1. A hypervisor driver can be conservative and steal an msix of the VF
> > for transporting intx.
> > Pros: Does not need special things in device
> > Cons:
> > a. Fairly intrusive in hypervisor vf driver.
> > b. May not be ever used as guest is unlikely to fail on msix
>=20
> Yea I do not like this since we are burning up msix vectors.
> More reasons: this "pass through" msix has no chance to set ISR properly =
since
> msix does not set ISR.
>=20
>=20
> > 2. Since multiple VFs intx to be serviced, one command per VF in AQ is
> > too much overhead that device needs to map a request to,
> >
> > A better way is to have an eventq of depth =3D num_vfs, like many other
> > virtio devices have it.
> >
> > An eventq can hold per VF interrupt entry including the isr value that
> > you suggest above.
> >
> > Something like,
> >
> > union eventq_entry {
> > 	u8 raw_data[16];
> > 	struct intx_entry {
> > 		u8 event_opcode;
> > 		u8 group_type;
> > 		u8 reserved[6];
> > 		le64 group_identifier;
> > 		u8 isr_status;
> > 	};
> > };
> >
> > This eventq resides on the owner parent PF.
> > isr_status is read on clear like today.
>=20
> This is what I wrote no?
> lore.kernel.org/all/20230507050146-mutt-send-email-
> mst%40kernel.org/t.mbox.gz
>=20
> 	how about a special command that is used when device would
> 	normally send INT#x? it can also return ISR to reduce latency.
>=20
In response to your above suggestion of AQ command,
I suggested the eventq that contains the isr_status that reduces latency as=
 you suggest.

> > May be such eventq can be useful in future for wider case.
>=20
> There's no maybe here is there? Things like live migration need events fo=
r sure.
>=20
> > We may have to find a different name for it as other devices has
> > device specific eventq.
>=20
> We don't need a special name for it. Just use an adminq with a special
> command that is only consumed when there is an event.
This requires too many commands to be issued on the PF device.
Potentially one per VF. And device needs to keep track of command to VF map=
ping.

> Note you only need to queue a command if MSI is disabled.
> Which is nice.
Yes, it is nice.
An eventq is a variation of it, where device can keep reporting the events =
without doing the extra mapping and without too many commands.

Additionally, eventq also works for 1.x device which will read the ISR stat=
us registers directly from the device.

>=20
> > I am inclined to differ this to a later point if one can identify the
> > real failure with msix for the guest VM.
> > So far we don't see this ever happening.
>=20
> What is the question exactly?
>=20
> Just have more devices than vectors,
> an intel CPU only has ~200 of these, and current drivers want to use 2 ve=
ctors
> and then fall back on INTx since that is shared.
> Extremely easy to create - do you want a qemu command line to try?
>=20
Intel CPU has 256 per core (per vcpu). So they are really a lot.
One needs to connect lot more devices to the cpu to run out of it.
So yes, I would like to try the command to fail.

> Do specific customers event use guests with msi-x disabled? Maybe no.
> Does anyone use virtio with msi-x disabled? Most likely yes.
I just feel that INTx emulation is extremely rare/narrow case of some appli=
cations that may never find its use on hw based devices.

> So if we are going for legacy pci emulation let's have a comprehensive le=
gacy
> pci emulation please where host can either enable it for a guest or deny
> completely, not kind of start running then fail mysteriously.
A driver will be easily able to fail the call on INTx configuration failing=
 the guest.

But lets see if can align to eventq/aq scheme to make it work.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

