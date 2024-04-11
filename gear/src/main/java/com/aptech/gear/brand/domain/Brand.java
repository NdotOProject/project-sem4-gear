package com.aptech.gear.brand.domain;

import com.aptech.gear.product.domain.Product;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "brands")
public class Brand {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(
			length = 100,
			unique = true
	)
	private String name;

	private String description;

	@OneToMany(
			targetEntity = Product.class,
			mappedBy = "brand",
			fetch = FetchType.EAGER,
			cascade = CascadeType.ALL
	)
	private Set<Product> products;

	public Brand(Long id, String name, String description) {
		this.id = id;
		this.name = name;
		this.description = description;
	}

	@Override
	public boolean equals(Object o) {
		if (o == null) {
			return false;
		}

		if (this == o) {
			return true;
		}

		if (!(o instanceof Brand brand)) {
			return false;
		}

		if (!Objects.equals(id, brand.id)
				    || !Objects.equals(name, brand.name)) {
			return false;
		}

		if (!Objects.equals(description, brand.description)) {
			return false;
		}

		Map<Long, Product> map1 = products.stream().map(
				p -> Map.entry(p.getId(), p)
		).collect(
				Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue)
		);

		Map<Long, Product> map2 = brand.products.stream().map(
				p -> Map.entry(p.getId(), p)
		).collect(
				Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue)
		);

		if (map1.size() != map2.size()) {
			return false;
		}

		for (Long key : map1.keySet()) {
			Product p1 = map1.get(key);
			Product p2 = map2.get(key);

			if (p2 == null) {
				return false;
			}

			if (!p1.getId().equals(p2.getId())) {
				return false;
			}

			if (!p1.getCode().equals(p2.getCode())) {
				return false;
			}

			if (!p1.getName().equals(p2.getName())) {
				return false;
			}
		}

		return true;
	}

	@Override
	public int hashCode() {
		int result = id != null ? id.hashCode() : 0;
		result = 31 * result + (name != null ? name.hashCode() : 0);
		result = 31 * result + (description != null ? description.hashCode() : 0);

		int productsHashCode = 0;

		if (products != null) {
			for (var p : products) {
				Long pId = p.getId();
				String pName = p.getName(), pCode = p.getCode();
				int pHashCode = pId != null ? pId.hashCode() : 0;
				pHashCode = 31 * pHashCode + (pName != null ? pName.hashCode() : 0);
				pHashCode = 31 * pHashCode + (pCode != null ? pCode.hashCode() : 0);

				productsHashCode = 31 * productsHashCode + pHashCode;
			}
		}

		result = 31 * result + productsHashCode;
		return result;
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();

		final String br = System.lineSeparator();
		final int indent = 2;

		sb.append(getClass().getSimpleName())
				.append(" {")
				.append(br);

		sb.append(
				"\"id\": ".concat(
						String.valueOf(id)
				).indent(indent)
		);

		sb.append(
				"\"name\": ".concat(
						name != null
								? "\"" + name + "\""
								: "null"
				).indent(indent)
		);

		sb.append(
				"\"description\": ".concat(
						description != null ?
								"\"" + description + "\""
								: "null"
				).indent(indent)
		);

		sb.append("\"products\": [".indent(indent));

		if (products != null) {
			int i = 1;
			for (var p : products) {
				StringBuilder pSb = new StringBuilder();
				pSb.append(p.getClass().getSimpleName())
						.append(" {")
						.append(br);

				pSb.append(
						"\"id\": ".concat(
								String.valueOf(p.getId())
						).indent(indent)
				);

				pSb.append(
						"\"code\": ".concat(
								p.getCode() != null
										? "\"" + p.getCode() + "\""
										: "null"
						).indent(indent)
				);

				pSb.append(
						"\"name\": ".concat(
								p.getName() != null
										? "\"" + p.getName() + "\""
										: "null"
						).indent(indent)
				);

				if (i < products.size()) {
					pSb.append("},");
				} else {
					pSb.append("}");
				}

				sb.append(pSb.toString().indent(indent * 2));
				i++;
			}
		}

		sb.append("]".indent(indent));

		sb.append("}");

		return sb.toString();
	}
}
