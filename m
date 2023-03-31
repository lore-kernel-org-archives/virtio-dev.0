Return-Path: <virtio-dev-return-11881-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53232C77B60
	for <virtio-dev@archiver.kernel.org>; Fri, 31 Mar 2023 21:24:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A46DB2CADA
	for <virtio-dev@archiver.kernel.org>; Fri, 31 Mar 2023 21:24:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 93A25986591
	for <virtio-dev@archiver.kernel.org>; Fri, 31 Mar 2023 21:24:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 897F9984282; Fri, 31 Mar 2023 21:24:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7307498657F;
	Fri, 31 Mar 2023 21:24:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSafplOS0WIh2iy4az0IV/lDHp27MoGSp5ttUiqIb66mMrWw/GPAu9qdyv3tfHwr2ptA8XqBWmK/WDwYEOtCJiYYtNjkYczDNxequE88xue3CVP0VY7Wa/Xk6F9z2/0wE1j6vwEtmwsTnvFsclYyiY6r6puEKJT5zVCIDvJn8WnXkJYOK/R7QlKSLMEIDTSZFLHiYXr44rf1BCTHm1+GhhBqiCDZmYUntCy/+NUatfQ+jCuB6HXp6MT2TV1i/dJqh51ptvJjUSHMcLQzTGkRJNaFt94ykOCc/YVCvXIeaaBwU3bcrCynRtE/mhCPTjQEBLwaupF0bBvAb4Neny5ZAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEyf10FD7VsMfvhUfy/xTxdKcJUOwEI3TpAmAUr5XTY=;
 b=Qva7ircxrQ1whZ4/vOK4SEnJjAYqAw5773vJKkJKRYGaJsjgsTIGfvzVsQ3Thz/7+pk2X/LQyqX4KNQV5Oax4dsKmTB6Nnsok4VheGHRflx0ARdmDc3HM21T3p+YNLPMKj0acKEg6FsjAABSWYQE9CcGmczT7FYgPn+/csE1e0tsuWESqJWeFxpiAuvzAMrKa33NWwDCUIlAy1en0lQ76V3EB3RiizeVpUtam0CRNr+NE1LUp5/y5JV5oXl2OTVh59UY/9uiSmnkuX+bkcgfpk8v8YJ+OUf2s2hqjrG4PSoHM9mLMzu6TS0xQ+JqevKByUWYhKNbGoE6Wj2DvyJPAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>
Thread-Topic: [PATCH 02/11] transport-pci: Move transitional device id to
 legacy section
Thread-Index: AQHZY1tGdy5B+WGsTEetsq6ex3gwSa8UcZ4AgAD0knA=
Date: Fri, 31 Mar 2023 21:24:21 +0000
Message-ID:
 <PH0PR12MB5481977FD9EF430B891A1F3FDC8F9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-3-parav@nvidia.com>
 <20230331024233-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230331024233-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL3PR12MB6378:EE_
x-ms-office365-filtering-correlation-id: 4725b405-ff03-407d-4f6b-08db322e4b8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 aoBA8hAW7SGnd4NdPm/dpEgQ0wBnDCX4ORVIDc+jgUY/oNueGJchiwit/cJnRZDzjUCd2ghQY5V9NKsriGMucHxmKFwtYw3ey6aetJk5LJxPdmOpnBcj+R6RNnQKcQKNpdL/EsjNa7CHOGtqSv9UESlyNrQfSwm1StNJ3CUh4gPyBEbzUlX4s9SxV31p8TpJzm33PKEJagjJrqfmTZ51jVc/T3/qUhtrkMHnSNSXe60k2xqkfSdeDXIYvMBMJSjeAKcIOFwJaQjVZqvtEywc7tf5Z/Z2g+miprhScOrZvhS1h7WJ7GncFrfui4u827zOhMeAQpalObEIpsLkLJHxcn3T69fhqOLd37fI6pFqTS7wI5jueSK2wcHD1MTKwxqpiYtGlbpLzbl3Qc/wpgW9SUyIH44bIu6yUxOsfWhY0NYm9OaJD63X7XfcGWTDWDpxHlblMQhu2dq2+RaXFnoHc8TIm0xy035LtJB0B2SrbkvQEq40GXaQP7uOXW0aroubY8Isla4ilFvbEwDtQcfp8H/2CzxBV++v4N6pUoM9GLkuWfgGTmQuPw8HdeD/FQvJW0EWLVaq/iYjZgE+frv3ybbvF9RSVIzG3LfXGny9VOt/DoBHisb3/gH0544yQwvQ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199021)(5660300002)(122000001)(38100700002)(52536014)(8936002)(4326008)(6916009)(86362001)(8676002)(64756008)(66556008)(76116006)(66946007)(66476007)(66446008)(41300700001)(55016003)(38070700005)(2906002)(71200400001)(33656002)(186003)(9686003)(6506007)(7696005)(54906003)(316002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wpCxjbK15nSAMsiX/r+qVSWBuZhC/WAk689jiW0ctl1jU8NP87Kr6snXjo33?=
 =?us-ascii?Q?k8ToJQUQy8D6ql3HpFmFNaSP0Gk2uJFXcd9VwuNFG3PQGm/g2LREULrFzRW5?=
 =?us-ascii?Q?waacUgG22VfpuXmPRYHQlxV6cLqem8ykY/IeHzI+iJtLKK4Kw+QvTJyd5h+M?=
 =?us-ascii?Q?t9yZRR1zIfD/YlwukNy8CTJ9K/+o4xT7pBKhIIeB1h6qp5dAXeLV+l11xANJ?=
 =?us-ascii?Q?qHkQlsKYLIjdeS+KmPD3GGjnGUm9FuRAyr3evide2JLpDmrt8esghqxx6Np0?=
 =?us-ascii?Q?v6Agw2KGp7ASUBAUPWPDpR/fbzpv1pY0o427c+rEplNhvsz0UFpzi7P6RgLd?=
 =?us-ascii?Q?q/Giyl4wqiMXutKgUdujdzYCu0g55Dvp/MmGR1wKrtev8qqwbWsuBfqTHpRj?=
 =?us-ascii?Q?rGBI3yLbQBo1m0sx6fh5yKKYfuRYgcjs3icdDNe4SwMQBPX+2f3af8A4AGm5?=
 =?us-ascii?Q?m6fprq2OGv24GqfIDCNwmY08af1h7IVAdo1WY1G0n9nYoJ6hGTj1Wl2CgHl+?=
 =?us-ascii?Q?S2cIYFCtap0sWx41QeJ/5hSIoijlugp9vGVqlhRyM053/41Mr819HfUQCCAF?=
 =?us-ascii?Q?/flhIOAGBgREghBANeXjExZK0QP3F1WkZw+/AeTKCHLqAzRiJ5Ci1dyT8UM1?=
 =?us-ascii?Q?EmV743RzOeNLStXRmwPippI/SPiAsdHAf6CncClnZe2wNZoyKSJ1Ae5KPbh+?=
 =?us-ascii?Q?bI4YWynfDGWsJvciqeiusSFnkTgl19jCXWFtRnt4UDCE2yEhBPYwkupc3r1/?=
 =?us-ascii?Q?+13WCgh+4tJfNlWkUyDgdaZ2GaGdaRArQ18liSEMRNFlHh7V1csIFqDYpAJo?=
 =?us-ascii?Q?79E8+EQdg59ZeiTahsAfOM7sSxeVlDE7dH/4pE6irs/h1IBLPpWFf+naWpbu?=
 =?us-ascii?Q?+XEsIHLfpfD2IjGEQqfSnAo9Swmxa3QsUnJxGwusqRUUI/1JSd3kRUNfx0ub?=
 =?us-ascii?Q?H+PpuzHuTlZ9O2Df5mTS0OlBGR9M9ZNhV9ZWTWgLicqNNzngxBdrC6pl/+CG?=
 =?us-ascii?Q?+8HrWkWJs+4bdl+/yrtyPvcJYgGD1zli1kDsiissuRl9ZDUhxFfVmIZ6KqYc?=
 =?us-ascii?Q?Q+bL7wRCcZ2QgZqTLAfBMVkeousffe66C5gA+w6aGxrVRJzsm5tZ53RjoKgM?=
 =?us-ascii?Q?RdJiWMNjoa+RZX194hffGvYlCwedJYd0kT+kS1NKzYDaFKRn2taZ4/ul0Rb9?=
 =?us-ascii?Q?CgA2fj91d54Zsi28ovVsp5HbN09kPkV4WSzxpkcqdT/i4Aqs5hDaL4ZBYm0Q?=
 =?us-ascii?Q?ULzWbYPT1C67WbFgA6WfXN8i4BuR+TwFjHR1NTs/V0lKu9TO6dSQIrH1hB/h?=
 =?us-ascii?Q?AJ0rWoqau8LKhfgHSAZT/CyoDXuwd8ECARYxqmzjGO2oelI4IQG+ubd2ZkBa?=
 =?us-ascii?Q?V9iJwxTL1FYNClJeSHris5YvQz00Tq+z8yMnmZo+8wxXnIHZ58h5FzLSRKZs?=
 =?us-ascii?Q?zRQ2mJWXIOaDi7jtBrBu2jglCYfQe31XUSKUGP12aWrSnQPbeTyXoOslVvmN?=
 =?us-ascii?Q?xh7aABT2+HzNFXeW1PEkoRhA9pwe5ncb9ll9Muv4PaG2OyNdK71D8zljwcQx?=
 =?us-ascii?Q?qaVJ0hT2h5CMcgA7/ljpJurJ+Ym6173wBY+7j0vuJ557L47PTnHDN25GeJiL?=
 =?us-ascii?Q?QJC9VUxMa+9/WeUkUn/K0mU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4725b405-ff03-407d-4f6b-08db322e4b8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2023 21:24:21.9942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rHSm/Ee4ZJYqY0mZVJftocteypu/iBk1cbD02/eWc/BLVpV+BoYfrJUGx5dhf+QCUev83J4JerA3tj8M8BdTVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6378
Subject: [virtio-dev] RE: [PATCH 02/11] transport-pci: Move transitional device id to
 legacy section



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Friday, March 31, 2023 2:44 AM
>=20
> On Fri, Mar 31, 2023 at 01:58:25AM +0300, Parav Pandit wrote:
> > Currently PCI device discovery details for the transitional device are
> > documented in two different sections.
> >
> > For example, PCI device and vendor ID registers are documented in
> > 'Device Requirements: PCI Device Discovery' section, while PCI
> > revision id is documented in 'Legacy Interfaces: A Note on PCI Device
> > Discovery' section.
> >
> > Transitional devices requirements should be documented in "legacy
> > interfaces" section as clearly mentioned in 'Legacy Interface: A Note
> > on Feature Bits'.
>=20
> I already commented on this, I disagree.
> Modern drivers must be able
> to completely ignore legacy interface sections, but they do bind to trans=
itional
> device IDs.
> This change breaks this assumption.
>=20
Legacy interface section holds the detail about transitional devices.
We do not have,
"Legacy only" section.

It doesn't make sense to partial information in legacy and partial in other=
 place.
Modern drivers are not mentioned in the spec terminology section.

Can you please explain, how can modern driver ignore the text " Transitiona=
l devices MUST have a PCI Revision ID of 0." written in legacy interface se=
ction?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

