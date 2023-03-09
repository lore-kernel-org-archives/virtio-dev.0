Return-Path: <virtio-dev-return-11576-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC80C64EC4
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 14:30:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 020B326A36
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 14:30:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ED04C986720
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 14:30:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DBF8F9866F6; Thu,  9 Mar 2023 14:30:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C2F599866F7;
	Thu,  9 Mar 2023 14:30:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkFvfE5dvoQyuXV73GCCpn+pDilIWDLevCUNZwkZ3ATCaEpPRCVOSODb3oEL53PgLEcwmPyjzIexZ0YEELDj5/vgCJyHy9FZWBDxf+Y0+TejfAyLN/jVANYw/1wbIKYzzXWRu+Ur3Hqt+qTAIVX8PNc+j9COpH3w+FKEH7+lopfYc/CsoJr222bXi9PrF5J6Wn1gQiRhkXOROcifRzXktYpEWf5hkAUtQJp+wtHhk7vdGIKOnQnb6trXvk3CRW0Uw7yUcROxTApeMO4EBZUdOJ+z7x4C90R+ZNe0t1g+HbxLvONEhbrB2pqFd8vCQc89I360Rg4sWP+hkX6aAusMQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bcrtg5a5YYZJ//B606iDwE/oCt6477KZhxc1LgwDhdQ=;
 b=FRmAPlcXFbGT+S9htiCuClVVro4Vzksal07CbgM1e2ltPxUivHrj0/D4lKNhDete9cqHC2H4qzRqiM/yy3uiU/ou/mess5FAIB0JrIKtkX4rLI/4r3v6jBDoSkrm+D4aeKJmpkMBLAeGDlz51gyRkWEzmAHYNIQLkf/R8JamhArNhlXwx/ybpIjkxYpMoLZr6/NlSPOzENfUO4xFihZSRez2a5drgk58Y2MkwaKG3D1F73lP4HRu/3Cax3CocFruKfAydRA63oDeouhKuGUm1pC2S3uPBJKIjJdXUhpAeOtUvdN2cm7vXKnHlULc17RsqUumNPzxVClcawyW5/LmOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: David Edmondson <david.edmondson@oracle.com>, Jiri Pirko
	<jiri@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com"
	<nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>, "virtio@lists.oasis-open.org"
	<virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [virtio-comment] Re: [virtio] [PATCH v10 04/10] admin: introduce
 virtio admin virtqueues
Thread-Index:
 AQHZUaV1hq+swD5r7EeFCHM9rP6wha7wxScAgAAFDACAAFmxgIAACLQAgAA3RYCAAKrygIAAXFnAgAARIACAAACcoIAABP0AgAABAEA=
Date: Thu, 9 Mar 2023 14:30:52 +0000
Message-ID:
 <PH0PR12MB548138694D606CE68B9E0C3ADCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <ZAhdzCd6qwWydesz@nanopsycho>
 <20230308064505-mutt-send-email-mst@kernel.org> <ZAh61E/wQ/hSY/OI@nanopsycho>
 <18d51bc0-d759-1a05-cb7c-3d46c4ed2f1a@nvidia.com> <m2wn3rxgv5.fsf@oracle.com>
 <PH0PR12MB548150700B50006F9F174104DCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZAmLIc97Ud09YfGT@nanopsycho>
 <PH0PR12MB54817E2CEFF003E793C9B2F3DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <m2mt4mxbt5.fsf@oracle.com>
 <PH0PR12MB5481FD2D2365CC08A5CD1E64DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230309091904-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230309091904-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB6880:EE_
x-ms-office365-filtering-correlation-id: 5fbf0b61-7c8b-4a15-e0bd-08db20aae312
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 H1bCGPX6E4HfNG6fVQbBOqalAQEdns9vBWmjwLdR/aG7l+H87IGr9J4k7GPr2nQH364otknBV5MOD+2lqaojErrYlmWcXRs6jjIS1MmzXVLRQKkIDrITSN1UnzyLUEr5OxCi9bUdxbz0u4AB1o8sa1D+ZeNYtxKSy6Hx2xMnMTdrpftNJyMiJI2BuA87N8ISgJOuRK3jlNg1LDCtabNdQx8t2uOSepzcBRRS6ZAFe9awCBCKXNF8cQEzeWVyq9RrOgNQsyen1Qyr8dEhbPZ+03g4dMuelJ1JB3zMbyhRpBF7nK1v+UQ/I7AwIJfOS7qGmlMZGxYmNR+mA2MIdkOuyLJlxUQPYERr+4HidfWL9u+Dr38MeEGTWjoX2c9M1oO+2jsiegW6GsK+x+OrN3Gzy2m4GHIbEjwtlyOjgRP52INI6Elbu7RrZ3ehYQRbnzBxFhgDQjDxeztEGF0/7rdsj0Q0R65fZm8A0EskJ6QwBVEQ0NGxSL/WZ5ndbgE/0yBpDwi5aUFhvbfNztpqmk6Pi1/Qi73+yY53w1qXfR4twtPB9AtWu5xsYGG2olgo4joJM+uJPDI+bhhVhNHEqrictDB4oGsJHLvXGS4N2Kdg77+n34GGi9UJJYkk0BF5JDYSQYXZfp5Sw+a4JaifDwSEHYpjzRttSQNaWwsxM0Y5pS3cY7Hg9VWSJkwsrW3jfvAdXwzG4Q1z1lODWfVE2EFP/Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199018)(8936002)(54906003)(122000001)(52536014)(66946007)(41300700001)(83380400001)(7696005)(186003)(9686003)(6506007)(107886003)(71200400001)(8676002)(316002)(66556008)(38070700005)(4326008)(66476007)(33656002)(66446008)(64756008)(76116006)(55016003)(86362001)(6916009)(38100700002)(2906002)(478600001)(5660300002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Un92d/wMOybF3SYdlUw6iYqO/WGrS2EBJINMww7Zf7o+h6zuys6HQdj1xch2?=
 =?us-ascii?Q?85J4X/K+x3gxujnvn93UPCtw//sFmOAuL09flnATzxYIJSvd7I+yBBh3h7M2?=
 =?us-ascii?Q?lFthlGh4bIDEEfLKbIfecRZU8N9p9hWjMfsf501VsfEUz8DF+sS5XC4pzii7?=
 =?us-ascii?Q?xBXh966A+5Bs6E2FEBCfqXuzbY++O4xGn3Wy6IldHYic5s6zXv2u14HMgKwT?=
 =?us-ascii?Q?m8MNSSApcQWyBHw1jyHG7WMI57CjiSRGGoeTbtnJtfPD98K68KLjUapifRAS?=
 =?us-ascii?Q?iITEqpD2johYYrZNISoXDIRhh1wQ8af93luoDmyENCSUf60Y7712SNo7UeEt?=
 =?us-ascii?Q?cxA+cviCRCSXq0xWKCKJrK+4k6dbFqT3pIqiLRw+FhvDHW6nJDqifFAN/NlX?=
 =?us-ascii?Q?vKSgj8pKei4hqPFRpGuZjG9pPwmqMuUw+ujqY8lTcde8JTXOmG+AMVq1flin?=
 =?us-ascii?Q?5Rnv8KCJQPz30YD84gd1735peSaI4hvKlRuJHGNW1JJ7xZmq5yf+NlYZDIBQ?=
 =?us-ascii?Q?cdnc8+HV9jT1xDa/Cxnq9vjfCYc/Jcq2NIX6tHOGjQJkt+ts+RlEm11nLg5B?=
 =?us-ascii?Q?FDCvczrjPrFcLe+xUa0BSluIL3GaPc4BFDzmri6DE6CC2Xp078poQsr7p7yq?=
 =?us-ascii?Q?qFBwyoYLtxfYO89nDWLomYs6lWoDLbJsq6fdtlf3EKp6jRPHe2hy8dui+WyV?=
 =?us-ascii?Q?/KD6MCWJFDKaAohHirqvlTmYAiIQpxZNGh6DfPj6wKE+Kwp+h0gKWWNU7XJn?=
 =?us-ascii?Q?d5/ARsEIi5iikMA3ODpZfqWwYEAxF2E8kmzmCB+dYPsr+9O2fB2FD8pVUqUu?=
 =?us-ascii?Q?KQ0NNFrzwgWnOnQpGjsaxFbmoE4qAu7rwjNm293IklwRGRD/w9ssflQTNL6C?=
 =?us-ascii?Q?+ofmjhUbvUBf1xirzMk4SMyETD/CmeR1aCjRpKJ0KGsq4+8QBZfxPD4RULMl?=
 =?us-ascii?Q?M6TwnA5Uk1NwqaCogI5ZdrZoCptuykT1LZIRtFLCxZwPwnK6LODOVDZrhPYf?=
 =?us-ascii?Q?ZJhhFZ9dj4+eTN7+H+lYmCQrKPgvJvKSf6O/qwVwUf8pfYnPJTYq0wxK5GVx?=
 =?us-ascii?Q?9EgTsYiFf9sfBsY3CgALH/dkS2P33hI0t/Nx8p9rNmUQo7IEWSUkjvd7ROLs?=
 =?us-ascii?Q?CavPQPG6zNdaU+OR+cV1nkkw67XP+hZD2I3VcZ9MMAbeVPVo+H/09rlVCM4X?=
 =?us-ascii?Q?WpBtg2PwPux04FZyH+p3gLzR5OQoUw/pHWqZ+73lx4YbTWfnix/E1eTIqxWU?=
 =?us-ascii?Q?G3X0yYV1nEWcUZmYNJWO7pIiD3StCJdEBU097IiI9NM4gNY/Or2ZsJBb6/h7?=
 =?us-ascii?Q?0v46lgZot4lOwEVGCOVbqjMV1nGALne+Guo8T6YUxjR7TsksaiwqmvM5jYp7?=
 =?us-ascii?Q?EI5OtJ7KBKLVKMYZXIqjiG+2mTfrBLxRoPgKt3UqqOHnOub5VZOoYDbdP5CB?=
 =?us-ascii?Q?e2hZcEAbJaUoyAW97i/HsEuY93QNLqj+m73PR61OndaUCqrhOqjhGi0HnDcH?=
 =?us-ascii?Q?+3rIcsoX2rIlExkWIU6sMAdkFPsUc9YVgdOSFy21dUOnCO76+ug7ZbY2duDy?=
 =?us-ascii?Q?w6iUcQcr+vp0PvVTcGVtPBjsFHTTFKCO14tujK8oPzUzdmsAkwEWYZqHTMUv?=
 =?us-ascii?Q?bnCcMyGN/a50GKkM9jAZ/Xw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbf0b61-7c8b-4a15-e0bd-08db20aae312
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 14:30:52.8782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DLE63LJuV0n5BFbJBbIa62ZorD+ORzZa4ogbNl7vS0+QGhtJA1+YCmi84qbuX7+YCcXVqdavgL5RkWitGReiwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6880
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio] [PATCH v10 04/10] admin: introduce
 virtio admin virtqueues



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, March 9, 2023 9:23 AM
>=20
> On Thu, Mar 09, 2023 at 02:11:54PM +0000, Parav Pandit wrote:
> >
> >
> > > From: David Edmondson <david.edmondson@oracle.com>
> > > Sent: Thursday, March 9, 2023 9:03 AM
> > >
> > > Parav Pandit <parav@nvidia.com> writes:
> > >
> > > >> From: Jiri Pirko <jiri@nvidia.com>
> > > >> Sent: Thursday, March 9, 2023 2:31 AM
> > > >>
> > > >> Wed, Mar 08, 2023 at 10:25:32PM CET, parav@nvidia.com wrote:
> > > >> >
> > > >> >> From: virtio-comment@lists.oasis-open.org
> > > >> >> <virtio-comment@lists.oasis- open.org> On Behalf Of David
> > > >> >> Edmondson
> > > >> >
> > > >> >> In support of live migration, might we end up moving large
> > > >> >> amounts of device state through the admin queue?
> > > >> >>
> > > >> >Correct.
> > > >> >
> > > >> >> If so, that would seem to have some performance requirements,
> > > >> >> though I don't know if it would justify multiple admin queues.
> > > >> >DMA of the data through the proposed AQ is supported.
> > > >> >
> > > >> >If I understood Max correctly when Max said " This AQ is not
> > > >> >aimed for performance ", he means that AQ doesn't have
> > > >> >performance requirements as
> > > >> io/network queues to complete millions of ops/sec.
> > > >> >
> > > >> >it is several hundred to maybe (on the higher side) thousand
> > > >> >ops/sec during
> > > >> LM, provisioning use case.
> > > >>
> > > >> But isn't it good to design it for performance from start? I
> > > >> mean, state transfer of thousands of VFs at a time is definitelly
> > > >> performance
> > > related, isn't it?
> > > >>
> > > > It is. Which part of the proposed AQ doesn't cover this aspect?
> > > > The only issue that I see today is, that a given GET family of
> > > > commands q
> > > contains the read-only and write-only descriptors which require
> > > multiple dma allocations on driver side.
> > >
> > > I don't think that there is any assertion that the current proposal
> > > doesn't cover this.
> > >
> > > It was intended as an illustration to try and help determine whether
> > > multiple AQs for a single device was a requirement given existing
> > > anticipated usage, or a safeguard against potential future uses.
> >
> > Got it.
> >
> > So far my understanding is:
> > 1. Single AQ is enough for currently cited use cases
>=20
> FYI transport VQ work started off with multiple vqs.
>=20
Ok. so there may be some use case for transport VQ.
Worth to mention in the cover letter and things will be fine.
Actual review of the transport VQ and its use will be in the respective pat=
chset.

> > 2. Having the infrastructure to support multiple AQ is also good.
> > The extra cost of this infra is only one read-only field =3D aq count a=
s Michael
> proposed.
> >
> > 3. Ability to send multiple outstanding commands and execute them out o=
f
> order by device is/should be supported as long as IN_ORDER is not negotia=
ted.
> > Should it be relaxed for AQ that even if IN_ORDER is negotiated, AQ by
> default can be out of order queue?
>=20
> I feel there's no need: driver can just avoid negotiating IN_ORDER.
I didn't understand the "no need" part.
Do you mean to make use of out-of-order AQ commands, driver should skip IN_=
ORDER negotiation for the data path queues?
If yes, it may not be a big loss for the PF.

I am considering that since AQ is so fresh, it can keep itself detached fro=
m the IN_ORDER from the beginning.
This way AQ and data path queues stay on their own course.

> Generally I'm not happy with IN_ORDER and have some ideas to replace it w=
ith
> PARTIAL_ORDER, that will also address this.
>=20
> > 4. Driver is the sole owner to decide if it is modifying an object thro=
ugh AQ, it
> should synchronize with ongoing AQ command on the same object or not.
> > 5. If the command gets stuck for a very long time, the driver can recov=
er the
> AQ using the existing Q RESET facility.
> >
> > Do we agree with the above design thoughts?
> > Or there is a better design than this discussed, and I missed it?
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

