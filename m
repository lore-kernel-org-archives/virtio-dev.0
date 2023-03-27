Return-Path: <virtio-dev-return-11781-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD19FC76195
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 14:14:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 21CDF721EF
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 14:14:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1AE4E98634B
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 14:14:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 109E098627E; Mon, 27 Mar 2023 14:14:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F2416986260;
	Mon, 27 Mar 2023 14:14:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2ZGY5iBPpiTCa4FD3lIp+qU79nNQP7ZrGIxRM2SelTZqxJxz+1+WrX3CHC7XGm3efQG1QUdQSpzTX51Dkb25aCk/G1CwsQT9kLIM9OYLLD+aLSLdOHOR5nZu832bsaMH0IcE0e72x39JtWxlHPuJRTgEMWoQu35//V/8t80lWThjsfnEo9pza4HPwG2wIzGXyw4icCSzajwkqh+iW8+mpAd5O9rIa1S2H9E3/ggsmGCm618N3Eg+Xp0Tct1JecQBkxSdschp4ZGxGHftkbi/nFSFQgTtpKyXhQ3EKsd4S8w7nq4ylYUbz435ShbIxv5PRcILFHnT+P5clF1f3ndjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzIgDe96hG8Vb9hhCNYLbqAw3WUnD3Q0VcjtLNphVcM=;
 b=l1KwHeYYQT3EH+2fKSTs8e/gdBAb87xOIeAgNnwB0xSH3+GZ5gguYgnPlqGnlC/w6Ms6ZFAQLjyH0OM/dG1CzLbcemW2q5dkPn6ZlsNBmb2XSN7FMjbVOa4kQlY4xbUFhQ2OlIzUTTBYZMJPmaw0HxyCmMGSjtPVE5esqIpEcwew3SzIhsobKItHcMcJpb8ieQ+9EdVabu7H+jV+lhSZ+OoW3y24oc5jKpNjbo6LeWDUh/rtieh39doar9XMyBEF6ysA6UuAV85YBz2+Hvfcbf7tA9k3PYjGIS6U3fZE+rjk34bBBnFyQFPtqPJBIbT6FJ/+4Vx01WPFuvP1LREfoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Stefano Garzarella <sgarzare@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "pasic@linux.ibm.com"
	<pasic@linux.ibm.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Thread-Topic: [virtio-comment] [PATCH v6 4/8] transport-mmio: Refer to the vq
 by its number
Thread-Index: AQHZXeyrsZzk1iLx+E26bRPpm1k/E68OawWAgAA8MsCAAAVygIAABC4g
Date: Mon, 27 Mar 2023 14:14:24 +0000
Message-ID:
 <PH0PR12MB54813AFD0C455B5A3BAE8BB5DC8B9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230324010432.280330-1-parav@nvidia.com>
 <20230324010432.280330-5-parav@nvidia.com>
 <sfu7ficnxkfnjrpbl4mnc3lwanrcocxxnoegk7smwy5a4g3jtf@hgh3e3ex4hxv>
 <PH0PR12MB5481E49E7F5C8E4634EB2D00DC8B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <tzpnzzvujby6vep2ja34x5vz2dvi2nyzr4i6ssj4z2t46zqnzj@llrivtyqnnn3>
In-Reply-To: <tzpnzzvujby6vep2ja34x5vz2dvi2nyzr4i6ssj4z2t46zqnzj@llrivtyqnnn3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB7066:EE_
x-ms-office365-filtering-correlation-id: 1f157ef9-ffea-48a1-81b4-08db2ecd91ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xDv1zNfmRyuxriKO/ADVJsQwb6H9cLDM+YwPEqzsAUJs+DFOTpiy7kuY9sbJ8eeIeptMVwK7V425Y6shtvK0B8fZZhFA/w+DRhmF98NBIv/gVhuP0RHk1klfMXh8J6TjHnGcoU/VfLhbgp16szZcf1VHGMYG9BWyg/zKpUfjOaQZMQCS3W6ca+bYGH002DLT3SBbihRGVGmjaApLK2rWSK/I/PTHuJGz8wdsMStDQw6+mQzJQaG32d2oyf1HEBavfDz+0MpkY32GyGCw1NWDr7+1CTGWkPJv0YIjwEynUylVy85guSYEXJpjdPkT3xP+67jdZHOXLXwIQ5Q8g4aRkBpvRKf/6E3WOjsv6GmFWVVfZ9w/GCXk3IY9R0prz9P4+a9crkcRnBhS77muoZFRDVofOrpgQkuFzqg8hQGYuSWgtpxxp38x2Lj67AsUYsplniazpqCYwixIaQuEQxA0DcPfpO1ggRx6B1L4bUcmvsjAMr2/ilOpXc4cXhrhqqgLNSYLfvQXDeu8CuFcMpI58a7DRR+BvSBaknk1pguT30tOcEMW2kNq4OGZxcibQsr5pnA76gU2variDrfjiF3kY6fa6/bJUQhl1Sn2P1Rz+30H9PoWd9awOvw7yv5tQlXW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199021)(41300700001)(66446008)(558084003)(107886003)(66476007)(52536014)(55016003)(4326008)(38100700002)(66556008)(38070700005)(6506007)(122000001)(9686003)(64756008)(6916009)(7696005)(2906002)(86362001)(8936002)(186003)(5660300002)(478600001)(8676002)(66946007)(54906003)(316002)(33656002)(71200400001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jHsWkg5H88IEjxl5Rb61Jyf97nC87pRX/SXFiHnDL51NnaskTF6t1dZnTGjv?=
 =?us-ascii?Q?k3BVWrixt3NdxlLkVOVmlmEZ4zQAMJB4OhFBQpuaeci2/RKe3rcA70kEV5fk?=
 =?us-ascii?Q?wOWZAFUWqbFvbMJGnHEIc5WUaU0TFKFiROn2D0jrB9XOu00aCkJXfbIXqLwz?=
 =?us-ascii?Q?MItXA1dcVGqq/wf9bVCixHkzQrVfezMTpNmxIUde+aJbRyefqU5AbXYhxqjv?=
 =?us-ascii?Q?OXmXrhYfRXXbxlBAlFjkR39N1QJLKln5+TsVm8WtSF7LSM+bC6gU7/f002ch?=
 =?us-ascii?Q?Hd/V3A9KT1CV/tAOo1LncGK2DjyzK1Q+7PhGUl4FbNOh5GajOGOpbVaQmcCp?=
 =?us-ascii?Q?92wh2s4Hqyd5zTAdxwUUJ+xbvhlJmgQySbZzIqsMdjSZNp3nZjnxsLvhPwzm?=
 =?us-ascii?Q?7ca35yLbP344EL8VQOq3CvSTwwuR3N/kHkmbyGldFENg7Dz+m1LW/ORFU0VG?=
 =?us-ascii?Q?V3XbUonMDiwRLPKNhl66a1k8n398eTjSsSRnMmZM7gHSompx5ZhwdkxozPyA?=
 =?us-ascii?Q?oJBjL0LNX0ROlgntGA+dBkyGceyaq/t4Y34C8JC9vPdZJsccotoapPKiMHzg?=
 =?us-ascii?Q?4ZpGl4sxTUZwfcrF1z30f/XLTMDBtwSCK0aJP31suzwYVcuHb42S1HhMvLkl?=
 =?us-ascii?Q?lzrqcPAWu8KrnSWHz7BQkemro9aEI/laQwf8VX06urlQ44iGDKwe/EyqfCbA?=
 =?us-ascii?Q?ycxkjdEFzMKyBBRwA3Et92B1eu9S4QlnlR/Kw2jdAjBhJW3EkjJ+phywIMMJ?=
 =?us-ascii?Q?1x5lp74YTXbI6dJcJs0V7m2EH8k8i/DI9T3RoRTMD5W3A4a/8CC1UkydVsLV?=
 =?us-ascii?Q?HzAXhYzpKpnYASnbf3mVLNbbIs/k97+qjOq0baJEJRnJ/2LDHe8FpMXPUfc8?=
 =?us-ascii?Q?L4/mb/6Jj6UsQSlWqCsmZXSWevu8+gB0Hpv5tGS1vqK7buSDKzrWwMJrkUh6?=
 =?us-ascii?Q?71vXeQ/q5IWA0vecfNddvt5fCiUr63YjYrAvLhfyY192mcfDz9IADQ1RrC4i?=
 =?us-ascii?Q?i+mUyRT0M/ibIOpe5uUIhDNnp5SRvqWXyOoPy3y2BuHg7HIAG1aRjQHRBjkP?=
 =?us-ascii?Q?ufQYpepiTi5sM9ywPXsaPksnvjoU9lbM+6HT4NidN8PsD5+g4BekZhMDooLz?=
 =?us-ascii?Q?pjzoPGJOIFg1/V8xp/RIqgh0obiUJhb1R/yFSAtIPtO/bK8cx9cQHp1DQNAe?=
 =?us-ascii?Q?NsgzTJeaIy0l+1Za3xaf3tVSfFliKGmHnoKM6oil2dS91X+cbepDXL/ed+ww?=
 =?us-ascii?Q?kZtDIvzVI41YFS2F9re/SvXmKGkiyGcnUX7Gwo4oo3osej3yxhNCtnfk5nwY?=
 =?us-ascii?Q?9Bu18LZLa0vTL8vx/NEPMdt4+oEVVEzqia30lTSzbGXi3tccV2Js+gtajlA8?=
 =?us-ascii?Q?MibsInDnFDb0vH/3fMYNclJnXGrzFNIEoVOFal6maRquptmLr6w20OJNzsqO?=
 =?us-ascii?Q?hV3MXqPGEORq5rmxI6WtGUlY8VwYqTJQNCFDfrNzWfVjN02bYijEq1AJCULL?=
 =?us-ascii?Q?jw0HeKn+U3v95nkTo7CsxJFCUFVV4dGhMLNtGtF4bFnXFkrRJrckm9iRAMv/?=
 =?us-ascii?Q?+RUjiz53946TYHYAfQDEk+Z1lHUHVwwj4liBX2+SIf7FSGnqcrrxt7ik3v6V?=
 =?us-ascii?Q?1A598dWIRSvJBhcxefz5ePg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f157ef9-ffea-48a1-81b4-08db2ecd91ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 14:14:24.9919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kpa00YFPWd6oXvScy4xWEjNe//l2boaZrG0SYDEvUTRG5gEG/jKErCmBTDvSAotILhVPZ2jWf7mAfL1qUUX08A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7066
Subject: [virtio-dev] RE: [virtio-comment] [PATCH v6 4/8] transport-mmio: Refer to the vq
 by its number


> From: Stefano Garzarella <sgarzare@redhat.com>
> Sent: Monday, March 27, 2023 9:59 AM
> >>
> >With Michael suggestion, the first patch describes the vq number range.
>=20
> I see.
>=20
> >I think we can drop this duplicate text from here all together.
> >
>=20
> Yep, I agree on that.

Ok. thanks.
Will send v7 fixing this.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

