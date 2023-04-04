Return-Path: <virtio-dev-return-11988-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F479C6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 21:20:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 776A041EE9
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 21:20:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4CF35986599
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 21:20:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 321EB983B4D; Tue,  4 Apr 2023 21:20:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BDDA898658B;
	Tue,  4 Apr 2023 21:18:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8F2WvMxoHjT1SuL7cQvJoe0b2VKLaK+Y27+EruhKAfmXMxg/hrwTK/9+Iinmh+n/D8t19IU23KVxWgUy7XYqwG/rrLq+lwjDXDK/Yx49VXr6Pulq4YGlFzCffQv+mxLOMO9YiCYiU7nNaQdh4RANrASI8xtOMqbSmiCnqQ4WCm6pK90NAwbqhA4gILGQZT7t4lLA7xuYDWVBKZpAZ6OfOM2t9aqLUSCyJEMxGU6JqqDULyHBZoeiiAVNoJ1aqM7gxuXDifbwo0dDPMWM4z3ZeQA2r2x8u6OWjC0QnY/ChOK2Cil13dCb5KKuJImBHciY8TLz7qpV58tpPXKt21yyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mR7CmdmcEbMG6KARPbADTydAbTHPUnEuycmSTz8YPjA=;
 b=ZIrlgolTvakJEEOr2YfG/B5FyK0vDevVHwFhYjg0DsTd76AomUP9vMDpFsAAmkgdFzsiH9dvTHvnqmAlDdikuGFJQG817oj/e+ugjfmRCft6yOFsNSNq78VEPhqXThJp2Z7qIpyPaofqT2suLJRAosaxnKpHB+Zx8LT/QpTc+1J77Uk4TpGXX80pXfWermu7FrROz5hRfWFD5Wp4nQUr5Wnqd6dM8BgoQkxX1/SEP7acB4HWxAodJoIaQNpLZHgcxyjLe1BO8v3Ufk0/8rQ0d9c7VsZzmEsVafc0iCuT+GoNnoJw1/T47ExpjfvTR8kSvGrn8ngA4yhSIBV0T4qDRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>
Thread-Topic: [PATCH 08/11] transport-pci: Introduce virtio extended
 capability
Thread-Index: AQHZY1tK9bYi+VUlRk+f1PKXMn2Qra8ayT6AgADjhmA=
Date: Tue, 4 Apr 2023 21:18:53 +0000
Message-ID:
 <PH0PR12MB548157060FCDB5B38CA63C8ADC939@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <20230404032922-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230404032922-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB6113:EE_
x-ms-office365-filtering-correlation-id: aa73faaa-f04c-415f-7c6c-08db35523159
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ChIW+IUv6ju9nPzSf2K3wWjYBn4Xtd4aT+t7pXzfKjBd34gorZcqHCETpvnRopAQNVaA4qoKp+uCssebkAGQIDAUyKnobDDTS7g/CUwWa2N9WgdgiQUByKdG1ooT8nmLbWOpleFiaWS2NDTfOYhnqzvagSgHtYpisj/aeQjTgEVb9ST6uGGLhhDAY1Awr5x75qKpQrCx3NFzz6tpmN2OmeUlCJP9npAwG81JfHVUkfDa+U5StF+QWDiC5RgTY65EusPI1929u/mQ5zxPjpeV4ptYAoeT3yOiupQK6x8Dekn3uPA+P0UPlVMVcrz3IqXsiFBjoJ725P+3Ga2jHDegGrcuDu+5xykbnOy/NgXIm+Sh0Qt36adVMA+aJL53lv4I624x8f0bw1unF47n6JgWdrt26q/IifpAjcMBkSlozGVgR10J87NRnddQhSdu4Fxho8vQ2Je/+Yt5v6yM+31O4bv16fMdeeTKDGweWdzK2xCzwI/v/0KEmz/MVg9TRZucsK2cHuEZftF6j3H5djVRMNjiT+goIodLYtWHPZlThS1B4Gu7AAiRW7fTgTSw0FY87NgxrBTB5wv6a1sPMaphHf6shiLfQ4fyGXsOEjDL0qfEekYghBdNSRd3DTW3CjnP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(38100700002)(7696005)(478600001)(122000001)(8676002)(316002)(41300700001)(4326008)(26005)(186003)(9686003)(66556008)(6916009)(6506007)(66476007)(64756008)(66446008)(76116006)(66946007)(2906002)(5660300002)(52536014)(33656002)(86362001)(71200400001)(54906003)(8936002)(38070700005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LhFbHxDIZ/TyFVF/z7DhOt/arC+cKWQXIlBEJ5lDKrG3xpkDuqyUMuyA+G0M?=
 =?us-ascii?Q?jBZvdmTOTjUYT5jd7BurgyoqS7z9n8OR3ASNazDYSZAtQunHujdX3pfEX1PZ?=
 =?us-ascii?Q?l5zMuqE6LLYfARyw+n0Q2K3hjxqR94MqErnm+21La319HAJ9gMGjEHVqP5zA?=
 =?us-ascii?Q?Aqyoilvinxp5pqp2zkTtQjPWcfmt3uP5VDntqt2uX5WwuXznT6W8GeqP+4aK?=
 =?us-ascii?Q?dsHxIHGIqZj56a6lRqcV629RnlWVvIH26ahlpVLFzwLVQqdNCICRioj9nDhU?=
 =?us-ascii?Q?+BWilN6+233UHFWATy0E89ZsfINxM2i7iWCu7XeXp+Zbz5CakVnXnezTEYTe?=
 =?us-ascii?Q?DMXFTVCzpeYmwVtmfuCHr8Ccqz/SLgpMKQArhyp9yF8pd4dAkbXuzybgxkJO?=
 =?us-ascii?Q?yiF3jtSUorQoLmpUIUQd+eaVXIhyC/g7FJWHEoMue311+HR6ohWLlJTEdARP?=
 =?us-ascii?Q?7Bggk2OBl99sAjgR25lq4eXFuSXP3BeBXhGA8AypsswVmmX1dW7OuJOWC9hV?=
 =?us-ascii?Q?nioZE+rBl/4pexzlaVbMpPTatO3Z9zsFix2JmB8Itg+ylibwUYGqyolXxR4t?=
 =?us-ascii?Q?ihJzcUG3Cl4CmQbkHhSDVUXXEFFUDQEz/czqSdQc6vzdkocpPjSb7B/74hcj?=
 =?us-ascii?Q?5ILyGKlwt/7DW8OMKuyqWiRGDOhaoJhySgEozROBXbLjZqZbFMssp0S8Gcbh?=
 =?us-ascii?Q?ePATCToOxrsaaQjDtKelrkbjp+pB8kh90/LutUgwMVSgOtxhyX8vKajzPk0J?=
 =?us-ascii?Q?FxsavwFZ5zJLgghLKZ3Bm2UPqJHp6TzKCxlyFB/Tk/4V2U3d4P4uioGtp9LE?=
 =?us-ascii?Q?qHkTuE7MECRIyRCwNO0giE1n3JFC1J3yuVf3xkR1hmY75WWT1Q2P6sThYyw7?=
 =?us-ascii?Q?yQGbRTvYmN0xSB2j0solMOhpmj9NIV2MEgMvJ/pDy0F1h7NUVX00eNNmOrfL?=
 =?us-ascii?Q?rOwlz8bpmSMMegeLU8ae38ImD4xeKJl7Xq0h5AlCl+jXa9qZ04VZDeOQNgqp?=
 =?us-ascii?Q?/IIsEJEXe9ULX0anQkmdklrLNWO8IVKbMMSfyglbQI8s66U3/RQ3JpzW6cGF?=
 =?us-ascii?Q?/CKXAeX+Cg8ZKIlT+poFLsJzk6RArk5mlFvA8ST+ge2VLyPYXQiXAgpb6Odo?=
 =?us-ascii?Q?SHXb+f1wpaPFNHWuK7WvfUiXmNyrwgEHTqkNGseGiqvr1MSMfKqrbkPvsNo6?=
 =?us-ascii?Q?05gwguoggMe+Ukg6Mhn3rWREDmmDwaGrcEeukGFbcVIQGcsVfP7DGkZlX5yW?=
 =?us-ascii?Q?J1U5YkGIMLM1qp5uL4ay0l39qtKu90Iqmxk+DAws+ubxaa31LBPmgNYgFAnc?=
 =?us-ascii?Q?AgcLDcPiaW0nLrFRYeO1ZB8JYQjp1F7iKammRBOp6isGnxEVvlB9PDSxdsNy?=
 =?us-ascii?Q?JSfyGcy3O8AfhgBbpfvLA0OKd9FUPaVSMB+m+DrM+1o6lRKMq2LeINgEy9W7?=
 =?us-ascii?Q?nWV5QV41pSjTaMRhavPSHfQLAX2qfz0UjCw71aRY3yQ5XJCf3n0vDR+iLQx9?=
 =?us-ascii?Q?vXpnuYty9zrWzd7vdPqe9cfhXqYW8Eh8Ezsyes+8mfblb4Q0mN1ueN91cnkE?=
 =?us-ascii?Q?2Z7Ekh1RPI6oLjOWqms=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa73faaa-f04c-415f-7c6c-08db35523159
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 21:18:53.4116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nNDFOVJmZ45BfRMf7Kj6z7cYoWl32vI+tkji2wX3a4ybgb6sUrjwfUk47YjgVjhnIPj0cLzRt9+Qk1xVSLAZGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113
Subject: [virtio-dev] RE: [PATCH 08/11] transport-pci: Introduce virtio extended capability



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, April 4, 2023 3:35 AM

> > +Virtio extended PCI Express capability structure defines the location
> > +of certain virtio device configuration related structures using PCI
> > +Express extended capability. Virtio extended PCI Express capability
> > +structure uses PCI Express vendor specific extended capability
> > +(VSEC). It has a below
>=20
> a layout below, or the following layout
>=20
Yes. somehow it got trimmed.
Will fix it.

> > +layout:
> > +
> > +\begin{lstlisting}
> > +struct pcie_ext_cap {
> > +        le16 cap_vendor_id; /* Generic PCI field: 0xB */
> > +        le16 cap_version : 2; /* Generic PCI field: 0 */
> > +        le16 next_cap_offset : 14; /* Generic PCI field: next cap or
> > +0 */ };
> > +
> > +struct virtio_pcie_ext_cap {
> > +        struct pcie_ext_cap pcie_ecap;
> > +        u8 cfg_type; /* Identifies the structure. */
> > +        u8 bar; /* Index of the BAR where its located */
> > +        u8 id; /* Multiple capabilities of the same type */
> > +        u8 zero_padding[1];
> > +        le64 offset; /* Offset with the bar */
> > +        le64 length; /* Length of the structure, in bytes. */
> > +        u8 data[]; /* Optional variable length data */
>=20
> Maybe le64 data[], for alignment?
>=20
It gets harder to decode (typecasting ..) if its string with le64 data type=
.
I will extend the comment,=20

+        u8 data[]; /* Optional variable length data, must be aligned to 8 =
bytes */

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

