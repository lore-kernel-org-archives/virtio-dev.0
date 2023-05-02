Return-Path: <virtio-dev-return-12494-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A507C77B7E
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 11:29:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8EF12F4C
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 11:29:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 821979864C3
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 11:29:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 76540986488; Tue,  2 May 2023 11:29:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 61C9E986485;
	Tue,  2 May 2023 11:29:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5J3nfsWRlpoZXfaoneLcLeRMbMckEIGm1JsJzbkaGn1tnllFZZGMa4ro15Mk+jXbxq7BpVbzSFegFg14Vo4HknzJcanqRf29vuFG/6wZ3RdpyPNre32bV3rxzHIFeFvPqsVNe5EIgyt/kN3c5iIOm23/NrDZCPKdnJn1E/U61gKwjiphKMOInOpH7scSrWbrNnjV+dvWggzi0QGfXjx1+Y+fl5Y7mD39CflEbIi/e1RgMoM2t4aPCyU3VqumR0g004LkrVXjlzMOKPOiVxam904POLABEDm7B41Aw/5b6R0MiALR/bUIKFD11OWBOrqJNM85++0MAQ54oSO4rDUIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhP2AhRjQdkmzYFA1wbXGVjWC+1LUXlGJVhjQvmmmaw=;
 b=an2NKbvCY2GgTCW+kvhxj1I/L2W5V4P7IbCtzjnPvtJW+HOh088uKSWPyFC9Z0nbgVOtmnONfFCAYYe3gA7NCuKWSD7N9aTg+VRzmbbU/lJiDDOHLmKMXCDGe3kIR0jfVTrSoT3LA5yGpogTtC8cBU5hIxMnm1ewPaJExESbBmcPGMfHdDvIMF0TFngEBI1iSk17nVMiQDShX1MCX6aqW4xA4JUfQTJS9W//HvngVUGcsQ+A1xqr9OKnSrJ9IWZhBa4LRjOdilQKZKau7B5wCg8eu/6mp9XSbWKLSO67lV1h3RvJY0KG6AnrrrlzAkuhaF8CiLNmbbG0I+5aTRogHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH 2/2] admin: Make optional command data type to u8
Thread-Index: AQHZfH6Ll9D3zH45GkaYn7RfQMElMa9GmQMAgABAUXA=
Date: Tue, 2 May 2023 11:29:03 +0000
Message-ID:
 <PH0PR12MB54813C5953966EAAB740C882DC6F9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230501224430.485139-1-parav@nvidia.com>
 <20230501224430.485139-3-parav@nvidia.com>
 <20230502033510-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230502033510-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY8PR12MB7243:EE_
x-ms-office365-filtering-correlation-id: 0ba79563-48dd-4636-a106-08db4b006ed7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tIdydVOAp0ukdb7Y53/uRybLa6ptDnVgaP8tNdkARfiynDe0b+2zKjEFhpobJWvEgYwGCGYJyUCYYF+AQvU7jKpS+uq4q0kVMUirbaiWIhgoJ2pw6LthBfg31+rXO5Q0phAGUWTssehbb0JHn7PHGKX6LLmeZi0HlclTWHT444dhEcNO/iivV8VNtIyP0WS6VxnccWwZX7mq1x9HKf92H71VQh0DuAutmBKRwiTuNc4zI8Y9j8/3AqQ+cTP5QuEcvnOH7tHMrJIWRG0RcQ1yjSAzVLvZ1bUST6SESraMvn2VUh9Qn4SkihNmq2wV/MLe9ekTV2oXlClFtQYp6PUaVDQDlwLUtkOWVCAcnsNnpTG8wBFl1lsFYgJiPQts1EaS1k2ojcElajheqwtjs6I2HHdAJbTwgSKvkFqxIeIQHuie3wlAuh6E6VIhi6nCn3yJCgRzUah25l723J/A991JSSk6m+5n5jKjfj1/w1D4WqvhP/rtAMjLqs/H/kJ1z1EPlvzoTdvT319MN/0VU+ZHo3lhiI0WsZBo71rUMBH6wxcnK1onIY2A88CYtYn+Xs95/6KC1KwNi6lNyU8OvpwQSiH5RSzmMiHDJ98saezY7ZevWycYNOMb0K3TELgsK5L9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199021)(83380400001)(6506007)(9686003)(107886003)(54906003)(478600001)(71200400001)(6916009)(26005)(186003)(7696005)(86362001)(4744005)(2906002)(52536014)(8936002)(8676002)(66446008)(38100700002)(33656002)(66946007)(76116006)(5660300002)(38070700005)(122000001)(55016003)(66476007)(66556008)(41300700001)(64756008)(316002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?E0SxHqfzZgk2/uLcxd+SRG+VMZVGcDafnSoDnlS3DZpNYsXrsc19UwnEnXvH?=
 =?us-ascii?Q?WAIGxitSdxvdUD4Q/+m8jK3t3B6ITTmiOQkjRpIEDGiew517plc4wPNkD2ZO?=
 =?us-ascii?Q?nKhNULvh6CSZJLARbV5tAxKM3wAcK2IOTxEjwtgvLHFiB+nuBRZ4fG3CzfiV?=
 =?us-ascii?Q?L6Id1eNDG2I/6x2MoDe8XfOuVQhINhbKPZGH8DV7NP0IC8Ws1WWXR5DiNKh1?=
 =?us-ascii?Q?VJBhhksrRdSorgk3VJ43i0FaDQWRs42uQQqbjL7023HSyYRTOHmdmp6oXC0k?=
 =?us-ascii?Q?+Xi3AJw20Oa387FGdO2og7i55Bjv2XpWl3768xDVomaxqZPnVJQMnEk2Ze6T?=
 =?us-ascii?Q?ycnbnSb+CWFa2JUKXChQtQeb5ydZ4+Hv3hw7u+uQqJelpOu7M5kV/wV5cavZ?=
 =?us-ascii?Q?+R5hveOjI7HeykEStcOpC80d4m0y5qJP45jIrPwOXTP/gy58+ledjyIApypL?=
 =?us-ascii?Q?7Ivm+7SkGaipJYr5gQJ7sZmGB/R1AGKjkzYaM7sFQ38H36KdicbGJqIk1AiE?=
 =?us-ascii?Q?gVEu+SKhsaP3G1tHZgio3z4evJ2Xfsha7daJu0l8O0TXkr9O5S4Z4d9GQQwW?=
 =?us-ascii?Q?d7hLjBloofXjLUu6nhfDPt/pUJS5wTb3tbhxwY3Al9jNFS6Wvc5Qh3/IbRIO?=
 =?us-ascii?Q?C3PPC5zO7PzSK3KChPIe6l041dmlyp8nITK5StHupxQzgJA4J9rC4bZZoXHY?=
 =?us-ascii?Q?Fy0om1qDq7D0/LV6EGgy5wNkT9s5kdahPLMOtqCftIKRuf8thgNjKCic+lAf?=
 =?us-ascii?Q?ac0X8oRPsLdVlBzkua2suOVvFS9BIiMM3IfVdhCdYpg8NtNDbASvhYijHjNw?=
 =?us-ascii?Q?zPziWu7fKt98GlG/ECX8DnK0Q1mHvS0Up2GlkaiSqlCWetME5Dp9B9l23dFE?=
 =?us-ascii?Q?XwNquuqfTEgJsw0sMhU95mYM7djXWVJ8mm2P19S3F9x/oQcw/a+UFJXTl9Oc?=
 =?us-ascii?Q?YKrcaZmXj+cIt/9OZR7SW5IB85fUx/f1u9yI9QVYiSlLV+8gxeImA6mK6e9X?=
 =?us-ascii?Q?u6U+F2qe7T3vq0e7tyiNuqN8G0ZtyvZQDEz+ANk21pDOPxCyGYEGquxalQlw?=
 =?us-ascii?Q?/rLtggyr+imd+iZTFsv/BPzmjvnXX8LDKYtWLypLQ2voAlw1DWBU78V/ydzZ?=
 =?us-ascii?Q?xuVtsW2yESxZ1AnR1pbmap7uCiFEw3RNJr8Jo/xMi170lIsbFD7ccHFT/rTn?=
 =?us-ascii?Q?2O/RXGErNP2IT9cWs7oawgnsdBJlha5O3B3/3szjqbYyBWXnjncGIfnrSJT0?=
 =?us-ascii?Q?AiE1GkfTdrvY/iG/TIALmQTlY/4fpeLydtJpjDOjZ0WdAZ1gPBp84pxrmmLr?=
 =?us-ascii?Q?jj4W4ut9yxSLQLwXTeZ4m4zcMSwsLuqNoC5jJnwi0vxLfhfU/1z+USxF9vLY?=
 =?us-ascii?Q?tnxOn8JOh4CHWBxaXvb2zSvNCrgGSkUUVppu3auk2Elf+36V+xx3+1aFVvZ6?=
 =?us-ascii?Q?qefDEw+rBMNva36mz6G2q5v2C+sM9OYn+nmpIm/pKtgEvs644wNH6BfK6/3R?=
 =?us-ascii?Q?Eixk6Eb+Mgq23NDdxTHPVvuOQ6S7vEib+SsNX1KBWdzsySQmf9vh/DRMRpEm?=
 =?us-ascii?Q?Uxn+zL8bEcX4qvmPxnI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba79563-48dd-4636-a106-08db4b006ed7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 11:29:03.4245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P0upKz/aOpE+SPkiMZkvJpiVA7s9nh5qqwo/dSMS9TOsK7U4xEMGHZ2xu2sAO8C5Tjghbag3/txqRdLppSlzsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7243
Subject: [virtio-dev] RE: [PATCH 2/2] admin: Make optional command data type to u8



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, May 2, 2023 3:38 AM
> Thanks for the patch. It was like this originally but readers were confus=
ed.  The
> point of marking it le64 is to make it clear it's size is a multiple of 8=
 bytes, thus
> 64 bits. And format of fields inside it is generally LE.

If it is supposed to be le64, the result should be same data type too, isn'=
t it?

>=20
> > ---
> >  admin.tex | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/admin.tex b/admin.tex
> > index 037e2e6..648253c 100644
> > --- a/admin.tex
> > +++ b/admin.tex
> > @@ -85,7 +85,7 @@ \subsection{Group administration
> commands}\label{sec:Basic Facilities of a Virti
> >          /* unused, reserved for future extensions */
> >          u8 reserved1[12];
> >          le64 group_member_id;
> > -        le64 command_specific_data[];
> > +        u8 command_specific_data[];
> >
> >          /* Device-writable part */
> >          le16 status;
> > --
> > 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

