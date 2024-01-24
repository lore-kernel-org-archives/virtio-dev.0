Return-Path: <virtio-dev-return-14271-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D67C47DDF
	for <virtio-dev@archiver.kernel.org>; Wed, 24 Jan 2024 11:23:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5DE5E21696
	for <virtio-dev@archiver.kernel.org>; Wed, 24 Jan 2024 11:23:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3DA889867DC
	for <virtio-dev@archiver.kernel.org>; Wed, 24 Jan 2024 11:23:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 296369867D7; Wed, 24 Jan 2024 11:23:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 18CAF9867D8;
	Wed, 24 Jan 2024 11:23:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUg7dhuQybphYj0W/YYu1Y6oYbkOgLnYYKS80RSyzbub/0iJG77FpgxJajhPqwOtpwR+zSbBC4l518ISS5z4hrS1upBP+nvDy5I0fvEmdfLLygQhjti3cH3hGIVZCB20CqCMWAHnfD0feEiDi49Brzhb+rCxz8N6yQqvDEp2RTESaYJ0akWjjhRvJ1TvI3Ud4hECJTalGjkBKiRuf13s1E/SLTSX2qThT633dXkjtm/YN0nkSpUiJGYZP5kJbp5EQL7j1l+dZeP+lXeX8Y75SFist4cCV8YevQordRSCfP3PAsutdAxFG5TXP51fwntN8k5XPHoDAnat8MkzdpXGjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehlmpxml7fCbHNfmCIjvVkL+S07LYnt7TtClucFBpAw=;
 b=B+O3cotcVKz5rob2IV8uvuSQH7GBajXs97umtzxYLjsvrp+Xzot8sr7qpIXUiVPociBn2g/n8LVRZIHMYvvNUZjb+q4AVbpEjxrA6iHYjHiEXbyCBuQdLGxacrXM8pOYApz/N15gyNAZUGTNuPVXPQ4Jo5mRZwC/onADl46Ijh/Idwoi6nvThxhOoTCqE3ZFCigje398IFfOFUpIOHzdJlqylaDFiQT4wm3bWIQkfwYl0geSCkwf3vBwpIlV27r2YnMLa+HHQej46JVSvCVEsQJzAXqvnxMRCDXSfNhfRMKP9QO7PBckxlqHYghcUq8F36mWq6Nt7Vt6Y0lpFoF1XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
CC: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
Thread-Topic: [virtio] [PATCH] virtio-net: clarify error handling for
 coalescing
Thread-Index: AQHaTra5zP+suc5aVUiOkR0Z8fj1E7Do0MZw
Date: Wed, 24 Jan 2024 11:23:08 +0000
Message-ID:
 <PH0PR12MB5481FF7AED1F50D7066AC16ADC7B2@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <ff9a6d805e7d510cde77b9989bef90aa21ffe4b4.1706094950.git.mst@redhat.com>
In-Reply-To:
 <ff9a6d805e7d510cde77b9989bef90aa21ffe4b4.1706094950.git.mst@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS0PR12MB7748:EE_
x-ms-office365-filtering-correlation-id: d41cc2aa-efcb-42d0-0419-08dc1cced7d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nHg48ihutNGeDh0Uahhe/XfGWXJoky8q2YC5xmU58LlQGu8rI/3xWQ+n/ES7nI8xCFzWXc6RjRMbTBfpKYadXFGRq0IrP1RhFy4UFJwgsxVLcmNtFPnexML9k320c2gYBngwh/Gvad37lg93iOE68AR92Fe2RJS7i3YZcnSTkP2Xs5BGUampXhtx0ICciVcojftzGF4H8AYXOgq8ANcnOjYIn3wbVsSAp5SulimlaSOci5LNEZ8lXSTqclPxKrIFUl7jEtT5clk1LPNzTgIUWo6a7z0dMvPjQytSPh7bNDcPwVglBCVUOjGgkHPzNk8VHHAgPJoWrzpfEZkecnq1dobC4vsE2Qai+KrqOJc5uMgNmIFuK6/YXiGMeTZV+24sWpJ19E1WTyUg++Akcl2vzYz8ChD6dw36ghLJe+tZlMfnFw291UKBs64E7SlBw1uhH+FqeNlk2I4RngnWS/vIlulbcPzsN9Sml3b5aBg+RScPNpUk5rKTw6S2TVbwaxZP82buKHq7ZZfXGT9bARVC+HaEfyijRoG5qWlj6oQhn0uW4HR9RPGNZ3U43oLtAgpP+NiWOHcbX7zSlGzOfEkcLKPOnhfLiFKXkeRAv5dvgnAuFZfPrU1uOo506y0Lpr61
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(38100700002)(55016003)(41300700001)(38070700009)(52536014)(76116006)(66446008)(66556008)(66476007)(64756008)(316002)(66946007)(7696005)(6506007)(110136005)(5660300002)(33656002)(53546011)(71200400001)(83380400001)(2906002)(122000001)(478600001)(8676002)(8936002)(4326008)(9686003)(66899024)(26005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?syPB6WZPxtWSxwOVbKUVTXB4rx1oDB5PHg1dOijJg+8iyYrTfhDt5ydWWqc6?=
 =?us-ascii?Q?9ls0umybk2zDyEbQV8EcgZv4irV0cKg8OdIzwFXeAIKaghCW/JwS8ZB6rAxU?=
 =?us-ascii?Q?CVPeFeAlEmrrVNbaxjm2I0xdNhYJLR6E8BKFnXjO3158fhHEiH8ML7olosZS?=
 =?us-ascii?Q?zB30sDGth8IvTN5VuZei6E5KqAmU8sastuzZmCRocyuHVBY4I9HyyGTSGWWw?=
 =?us-ascii?Q?oaSL5ZX324+j2akL1iOUleXfeL26znz6ydNJjs8ypGNJIsQxkq5qubTT/F2O?=
 =?us-ascii?Q?UXRJrbebk+cNzhx3lnOBPfKQpEfWQTx2fAOpiLT8+aojtzfMMmZqXvZUMgPs?=
 =?us-ascii?Q?7g/NJ2lKahaev8A/rhrm5lC72vI2XscSzWVmi3e3pl7L5+8SZErno4hIUfMS?=
 =?us-ascii?Q?O3pDvEDlLPTuUcRMx167CyQrdI/4ebq0I1ZcnMJXNTTN6wWAkGx7V1NSiguI?=
 =?us-ascii?Q?iVa0xP9GZ8n0kL5xt1pCsg0eCPwqlKGmg4h+ot41gnZqxUPmKnTx45NhVG/C?=
 =?us-ascii?Q?iAs9EhlVMGoStEhYw/cJTJciFLZPJJvQGiaX+0gP4ZcAr2HzxXHNzpxnjui7?=
 =?us-ascii?Q?DW5QDtpRi1hp93XIkSubFYJ2yznbfssnWXTAXtcKBjzhp/nuvecXa0sAY8wk?=
 =?us-ascii?Q?KP5WfTCVNX90bpXCebRNra5mpZRPYDgsnf0DUdVOoTgPhgz1LC+WLx9Xsi79?=
 =?us-ascii?Q?z6xcerUh+Uu3ynaalbixb1emYrItfzUfS3rP6rqI0HJpYJUr0To6uf56zFpx?=
 =?us-ascii?Q?9zvQn5dN1YVMkBY6eTzn73ChH+dywGnsBXUZ5DD1/Km0pukQLDf91aCzfaf4?=
 =?us-ascii?Q?s0vsTqS5+mifEBb7AzBahgnalcta6QMwWOLU8J8QKc7jeVMMW5kgycJ2JkUv?=
 =?us-ascii?Q?X5+jH3jNE7QndcebhsyUBqd359fZxK1rWmADkvmU50a/U9iFhma4wpNNmmBu?=
 =?us-ascii?Q?xMgFHPX1ooecrGdwG/g5QHyliljPfgJce2RAmSuEUCgXLyboVwTeQhsIE0B7?=
 =?us-ascii?Q?mfA2bTKpOLaUSOt7bZ3FfI8TWqvrOE4qvneEOiEXXrZj7UBCtSxLoEgaBfdx?=
 =?us-ascii?Q?7uAOjWdeDglij/DuoCesi8KlOk3/tsIkwU058UlIRtaekbqMi0hsKSpS4VuY?=
 =?us-ascii?Q?ogAHlZ+HPKRVpWNhJAU+5D/G9XS/9W7mDZi8D5eAvVi6jlzCjL4hRHNQnGUP?=
 =?us-ascii?Q?R1RqrUmR04D/o3pyIbxSllofTSEplqxNRgOH08aEpCEAu+q5JjvUN5yqPeit?=
 =?us-ascii?Q?v2oVLswX+AsQOU8Jr6vYt9rmVggNADe727F+NtkBDeHhZl9YL7mkxPAgU6BF?=
 =?us-ascii?Q?gyZAcXXPUHK2eorfEJivLrIlMcmocCmBIoioQW8rD4HZz9aYEiQD4W1wu2Jn?=
 =?us-ascii?Q?QR6Sxlzvsd3AIGbqW9fTKFVOhtsoINSJ5ioTAyyEGQvbvcDYvvVyiWaA/9lY?=
 =?us-ascii?Q?bQkhVMMNXaiOH4FNnpMGhhGFZY7EnRoKBSNWwGJbhoiO5FTCfzNR9Zy+6DxB?=
 =?us-ascii?Q?yrMG67fpvClFNfl9BVuf3EefaLf7ci2yVxIzRqip9cRLeqCj2fN6rd6nzPvk?=
 =?us-ascii?Q?fUtUnfu1AOx0rioS3aQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41cc2aa-efcb-42d0-0419-08dc1cced7d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 11:23:08.9592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WWGwJRx72lhbDkDUSGkBqUCKFCrab00dTPsaZhmNqQdZiQOwDD7hT5tKAaIVA/2aixlPW0JCQJQZ+jmePA9OmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748
Subject: [virtio-dev] RE: [virtio] [PATCH] virtio-net: clarify error handling for
 coalescing



> From: virtio@lists.oasis-open.org <virtio@lists.oasis-open.org> On Behalf=
 Of
> Michael S. Tsirkin
> Sent: Wednesday, January 24, 2024 4:46 PM
> To: virtio-comment@lists.oasis-open.org; virtio-dev@lists.oasis-open.org
> Cc: virtio@lists.oasis-open.org

Can we please avoid posting to three different lists?

> Subject: [virtio] [PATCH] virtio-net: clarify error handling for coalesci=
ng
>=20
> This is not a huge deal since it's a SHOULD anyway, so make the new
> requirement SHOULD too.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  device-types/net/description.tex | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/device-types/net/description.tex b/device-
> types/net/description.tex
> index aff5e08..d1d25fe 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -1792,7 +1792,11 @@ \subsubsection{Control
> Virtqueue}\label{sec:Device Types / Network Device / Devi
>=20
>  The device MUST ignore \field{reserved}.
>=20
> -The device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
> VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR if
> it was not able to change the parameters.
> +The device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
> +VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR
> if it was
> +not able to change coalescing parameters. In this case, the parameters
> +SHOULD remain unchanged, for all VQs.

Is the new added normative line without device is ok?

Or should it be written as
... In this case, the device SHOULD not update the parameters for all VQs.

?

> +
>=20
>  The device MUST respond to the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
> command with VIRTIO_NET_ERR if it was not able to change the parameters.
>=20
> --
> MST
For the functionality itself, ignoring above normative suggestion,

Reviewed-by: Parav Pandit <parav@nvidia.com>=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

